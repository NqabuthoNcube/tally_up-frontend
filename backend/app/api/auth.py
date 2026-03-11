from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.db.session import get_db
from app.models.user import User
from app.core.security import create_access_token

router = APIRouter(prefix="/auth", tags=["Auth"])


@router.post("/login")
def login(phone_number: str, db: Session = Depends(get_db)):

    user = db.query(User).filter(User.phone_number == phone_number).first()

    if not user:
        raise Exception("User not found")

    token = create_access_token(
        {"sub": str(user.id)}
    )

    return {"access_token": token}