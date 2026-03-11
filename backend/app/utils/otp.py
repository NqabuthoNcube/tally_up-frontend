import secrets
import hashlib
from datetime import datetime, timedelta


OTP_EXPIRY_MINUTES = 5


def generate_otp():
    return f"{secrets.randbelow(900000) + 100000}"


def hash_otp(otp: str):
    return hashlib.sha256(otp.encode()).hexdigest()


def create_expiry():
    return datetime.utcnow() + timedelta(minutes=OTP_EXPIRY_MINUTES)