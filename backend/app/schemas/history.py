from pydantic import BaseModel
from uuid import UUID
from datetime import datetime


class TransactionHistoryItem(BaseModel):
    transaction_id: UUID
    account_id: UUID
    signed_amount: float
    created_at: datetime


class TransactionHistoryResponse(BaseModel):
    items: list[TransactionHistoryItem]
    page: int
    page_size: int
    total: int