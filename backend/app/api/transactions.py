from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.db.session import get_db
from app.engine.transaction_service import TransactionService
from app.schemas.transaction import TransferRequest, TransferResponse
from app.core.auth import get_current_user

router = APIRouter(prefix="/transactions", tags=["Transactions"])


@router.post("/transfer", response_model=TransferResponse)
def transfer(
    request: TransferRequest,
    current_user: str = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    tx = TransactionService.transfer(
        db=db,
        sender_account_id=request.sender_account_id,
        receiver_account_id=request.receiver_account_id,
        amount=request.amount,
        current_user=current_user,
        reference=request.reference,
        idempotency_key=request.idempotency_key
    )

    return TransferResponse(
        transaction_id=tx.id,
        status="success"
    )