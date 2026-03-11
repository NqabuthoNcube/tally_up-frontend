from sqlalchemy.orm import Session
from sqlalchemy import select
from uuid import UUID

from app.models.account import Account
from app.models.transaction import Transaction

from app.engine.ledger_engine import LedgerEngine
from app.engine.balance_calculator import BalanceCalculator


class TransactionService:

    @staticmethod
    def transfer(
        db: Session,
        sender_account_id: UUID,
        receiver_account_id: UUID,
        amount: float,
        current_user: UUID,
        reference: str | None = None,
        idempotency_key: str | None = None
        ):
        """
        Transfer money between two accounts using double-entry accounting.
        Includes row locking and idempotency protection.
        """

        # Idempotency protection
        if idempotency_key:
            existing = db.execute(
                select(Transaction).where(
                    Transaction.idempotency_key == idempotency_key
                )
            ).scalar_one_or_none()

            if existing:
                return existing

        # Validate amount
        if amount <= 0:
            raise ValueError("Transfer amount must be positive")

        # Lock sender account row
        sender_account = (
            db.execute(
                select(Account)
                .where(Account.id == sender_account_id)
                .with_for_update()
            )
            .scalar_one()
        )
        
        # Verify sender owns the account
        if sender_account.user_id != current_user:
            raise ValueError("Unauthorized: account does not belong to users")

        # Lock receiver account row
        receiver_account = (
            db.execute(
                select(Account)
                .where(Account.id == receiver_account_id)
                .with_for_update()
            )
            .scalar_one()
        )

        # Check sender balance
        sender_balance = BalanceCalculator.get_account_balance(
            db,
            sender_account_id
        )

        if sender_balance < amount:
            raise ValueError("Insufficient balance")

        # Double-entry ledger entries
        entries = [
            {
                "account_id": sender_account_id,
                "amount": -amount
            },
            {
                "account_id": receiver_account_id,
                "amount": amount
            }
        ]

        # Create transaction through ledger engine
        return LedgerEngine.create_transaction(
            db=db,
            entries=entries,
            reference=reference,
            idempotency_key=idempotency_key
        )