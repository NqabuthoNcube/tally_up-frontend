import uuid
from sqlalchemy import Column, DateTime, Enum, ForeignKey
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.sql import func

from app.db.session import Base
from app.models.enums import AccountType, AccountStatus


class Account(Base):
    __tablename__ = "accounts"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=True)

    account_type = Column(Enum(AccountType), nullable=False)
    status = Column(Enum(AccountStatus), nullable=False, default=AccountStatus.ACTIVE)

    created_at = Column(DateTime(timezone=True), server_default=func.now())