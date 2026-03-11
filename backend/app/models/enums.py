import enum


class UserStatus(str, enum.Enum):
    ACTIVE = "ACTIVE"
    FROZEN = "FROZEN"


class AccountType(str, enum.Enum):
    USER = "USER"
    MERCHANT = "MERCHANT"
    SYSTEM = "SYSTEM"


class AccountStatus(str, enum.Enum):
    ACTIVE = "ACTIVE"
    FROZEN = "FROZEN"


class TransactionType(str, enum.Enum):
    TRANSFER = "TRANSFER"
    FLOAT_ISSUE = "FLOAT_ISSUE"
    CORRECTION = "CORRECTION"
    SETTLEMENT = "SETTLEMENT"