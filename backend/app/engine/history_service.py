from sqlalchemy.orm import Session
from sqlalchemy import func
from uuid import UUID

from app.models.ledger_entry import LedgerEntry


class HistoryService:

    @staticmethod
    def get_account_history(
        db: Session,
        account_id: UUID,
        page: int = 1,
        page_size: int = 20
    ):

        offset = (page - 1) * page_size

        query = db.query(LedgerEntry).filter(
            LedgerEntry.account_id == account_id
        )

        total = query.count()

        rows = (
            query
            .order_by(LedgerEntry.created_at.desc())
            .offset(offset)
            .limit(page_size)
            .all()
        )

        return rows, total