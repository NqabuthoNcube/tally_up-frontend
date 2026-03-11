import uuid
from sqlalchemy import Column, DateTime, Enum, String
from sqlalchemy.dialects.postgresql import UUID, JSONB
from sqlalchemy.sql import func
from sqlalchemy import Column, String

from app.db.session import Base
from app.models.enums import TransactionType


class Transaction(Base):
    __tablename__ = "transactions"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)

    type = Column(Enum(TransactionType), nullable=False)
    idempotency_key = Column(String, unique=True, nullable=True)
    extra_data = Column(JSONB, nullable=True)

    created_at = Column(DateTime(timezone=True), server_default=func.now())