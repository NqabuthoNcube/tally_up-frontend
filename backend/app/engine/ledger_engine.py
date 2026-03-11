import uuid
from sqlalchemy.orm import Session

from app.models.transaction import Transaction
from app.models.ledger_entry import LedgerEntry


class LedgerEngine:

    @staticmethod
    def create_transaction(
        db: Session,
        entries: list[dict],
        reference: str | None = None,
        idempotency_key: str | None = None
    ):
        """
        Create a ledger transaction and its corresponding ledger entries.

        entries example:

        [
            {"account_id": UUID, "amount": -100},
            {"account_id": UUID, "amount": 100}
        ]
        """

        # Enforce double-entry invariant
        total = sum(e["amount"] for e in entries)

        if total != 0:
            raise ValueError("Ledger invariant violated: entries must sum to zero")

        # Create transaction record
        tx = Transaction(
            id=uuid.uuid4(),
            reference=reference,
            idempotency_key=idempotency_key
        )

        db.add(tx)
        db.flush()  # ensures tx.id exists before inserting ledger entries

        ledger_rows = []

        for entry in entries:
            ledger_rows.append(
                LedgerEntry(
                    transaction_id=tx.id,
                    account_id=entry["account_id"],
                    signed_amount=entry["amount"]
                )
            )

        db.add_all(ledger_rows)

        db.commit()

        return tx