from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session
from uuid import UUID

from app.db.session import get_db
from app.models.account import Account
from app.schemas.account import AccountCreate, AccountResponse, BalanceResponse
from app.engine.balance_calculator import BalanceCalculator
from app.engine.history_service import HistoryService
from app.schemas.history import TransactionHistoryItem, TransactionHistoryResponse

router = APIRouter(prefix="/accounts", tags=["Accounts"])


@router.get("/{account_id}/balance", response_model=BalanceResponse)
def get_balance(account_id: UUID, db: Session = Depends(get_db)):
    balance = BalanceCalculator.get_account_balance(db, account_id)

    return BalanceResponse(
        account_id=account_id,
        balance=balance
    )
    

@router.get("/{account_id}/history", response_model=TransactionHistoryResponse)
def get_history(
    account_id: UUID,
    page: int = Query(1, ge=1),
    page_size: int = Query(20, le=100),
    db: Session = Depends(get_db)
):

    rows, total = HistoryService.get_account_history(
        db,
        account_id,
        page,
        page_size
    )

    items = [
        TransactionHistoryItem(
            transaction_id=row.transaction_id,
            account_id=row.account_id,
            signed_amount=row.signed_amount,
            created_at=row.created_at
        )
        for row in rows
    ]

    return TransactionHistoryResponse(
        items=items,
        page=page,
        page_size=page_size,
        total=total
    )
    
@router.post("", response_model=AccountResponse)
def create_account(request: AccountCreate, db: Session = Depends(get_db)):

    account = Account(
        user_id=request.user_id,
        account_type=request.account_type
    )

    db.add(account)
    db.commit()
    db.refresh(account)

    return account   