from sqlalchemy.orm import Session
from sqlalchemy import func
from uuid import UUID

from app.models.ledger_entry import LedgerEntry


class BalanceCalculator:

    @staticmethod
    def get_account_balance(
        db: Session,
        account_id: UUID
    ):
        """
        Calculates account balance by summing ledger entries.
        """

        balance = (
            db.query(func.coalesce(func.sum(LedgerEntry.signed_amount), 0))
            .filter(LedgerEntry.account_id == account_id)
            .scalar()
        )

        return balance