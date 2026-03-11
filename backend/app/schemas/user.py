from pydantic import BaseModel
from uuid import UUID
from datetime import datetime


class UserCreate(BaseModel):
    phone_number: str


class UserResponse(BaseModel):
    id: UUID
    phone_number: str
    status: str
    created_at: datetime