from pydantic import BaseModel
from uuid import UUID
from datetime import datetime


class AccountCreate(BaseModel):
    user_id: UUID
    account_type: str


class AccountResponse(BaseModel):
    id: UUID
    user_id: UUID
    account_type: str
    status: str
    created_at: datetime

    class Config:
        from_attributes = True


class BalanceResponse(BaseModel):
    account_id: UUID
    balance: float