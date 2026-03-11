from pydantic import BaseModel, Field
from uuid import UUID


class TransferRequest(BaseModel):
    sender_account_id: UUID
    receiver_account_id: UUID
    amount: float = Field(gt=0)


class TransferResponse(BaseModel):
    transaction_id: UUID
    status: str    
    
class TransferRequest(BaseModel):

    sender_account_id: UUID
    receiver_account_id: UUID
    amount: float
    reference: str | None = None
    idempotency_key: str | None = None    