import uuid
from sqlalchemy import Column, DateTime, ForeignKey, Numeric, CheckConstraint
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.sql import func

from app.db.session import Base


class LedgerEntry(Base):
    __tablename__ = "ledger_entries"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)

    transaction_id = Column(
        UUID(as_uuid=True),
        ForeignKey("transactions.id"),
        nullable=False
    )

    account_id = Column(
        UUID(as_uuid=True),
        ForeignKey("accounts.id"),
        nullable=False
    )

    signed_amount = Column(
        Numeric(18, 2),
        nullable=False
    )

    created_at = Column(DateTime(timezone=True), server_default=func.now())

    __table_args__ = (
        CheckConstraint("signed_amount <> 0", name="ck_signed_amount_nonzero"),
    )