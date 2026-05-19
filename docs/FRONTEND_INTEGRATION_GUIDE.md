# Frontend Integration Guide (REST + JWT)

This project contains:
- **Backend**: FastAPI under `backend/`
- **Frontend**: Flutter/Dart under `lib/` (uses `Dio` and a shared `ApiClient`)

Backend API docs (Swagger) are available at `http://127.0.0.1:8000/docs` when running the server.

## Base URL

Local dev default (from backend README):
- `http://127.0.0.1:8000`

Your Flutter client uses `AppConfig.baseUrl` and attaches it in `ApiClient` (`lib/core/network/api_client.dart`).

## Authentication

### Login

**Request**
- **Method**: `POST`
- **Path**: `/auth/login`
- **Parameters**: `phone_number` is sent as a **query parameter** (not JSON body)

Example:

```http
POST /auth/login?phone_number=+27821234567
```

**Response**

```json
{ "access_token": "<jwt>" }
```

### Authenticated requests

Include the JWT in all protected requests:

```http
Authorization: Bearer <token>
```

In Flutter, `ApiClient` already injects this header automatically from `SecureStorageService`.

## User onboarding

### Create user

**Request**
- **Method**: `POST`
- **Path**: `/users`
- **Body**

```json
{ "phone_number": "+27821234567" }
```

**Response** (shape per `backend/app/schemas/user.py`)

```json
{
  "id": "uuid",
  "phone_number": "+27821234567",
  "status": "active",
  "created_at": "2026-03-24T12:34:56.789Z"
}
```

## Accounts

### Create account

**Request**
- **Method**: `POST`
- **Path**: `/accounts`
- **Body** (per `backend/app/schemas/account.py`)

```json
{
  "user_id": "uuid",
  "account_type": "checking"
}
```

**Response**

```json
{
  "id": "uuid",
  "user_id": "uuid",
  "account_type": "checking",
  "status": "active",
  "created_at": "2026-03-24T12:34:56.789Z"
}
```

### Fetch balance

**Request**
- **Method**: `GET`
- **Path**: `/accounts/{account_id}/balance`

**Response**

```json
{
  "account_id": "uuid",
  "balance": 123.45
}
```

### Transaction history (paginated)

**Request**
- **Method**: `GET`
- **Path**: `/accounts/{account_id}/history`
- **Query parameters**
  - `page` (default `1`, min `1`)
  - `page_size` (default `20`, max `100`)

Example:

```http
GET /accounts/{account_id}/history?page=1&page_size=20
```

**Response** (per `backend/app/schemas/history.py`)

```json
{
  "items": [
    {
      "transaction_id": "uuid",
      "account_id": "uuid",
      "signed_amount": -100.0,
      "created_at": "2026-03-24T12:34:56.789Z"
    }
  ],
  "page": 1,
  "page_size": 20,
  "total": 42
}
```

## Transactions

### Transfer funds

**Request**
- **Method**: `POST`
- **Path**: `/transactions/transfer`
- **Auth**: Requires `Authorization: Bearer <token>`
- **Body** (per usage in `backend/app/api/transactions.py`)

```json
{
  "sender_account_id": "uuid",
  "receiver_account_id": "uuid",
  "amount": 100.0,
  "reference": "optional string",
  "idempotency_key": "optional string"
}
```

**Response**

```json
{
  "transaction_id": "uuid",
  "status": "success"
}
```

**Idempotency**
- Provide a stable `idempotency_key` for retries (e.g. request UUID). The backend is designed to avoid creating duplicate transfers when the same key is replayed.

## Recommended frontend architecture

Keep a simple separation between **networking**, **features**, and **state**:

- **core**
  - `core/network`: `ApiClient` + error normalization
  - `core/storage`: secure token + selected `account_id`
- **features/auth**
  - login screen + repository that stores `access_token`
- **features/accounts**
  - account creation + current account selection
  - balance polling/refresh
- **features/send**
  - transfer flow (amount → confirm → submit)
  - generate and persist an `idempotency_key` per submit attempt
- **features/history**
  - paginated list bound to `/accounts/{id}/history`

## Common frontend gotchas

- **Auth endpoint shape**: `/auth/login` expects `phone_number` as a **query parameter**.
- **Token storage**: store JWT securely (Flutter already uses `flutter_secure_storage`).
- **HTTP 401 handling**: on `401`, clear session and redirect to login.
- **Pagination**: keep `page` and `page_size` in state; append results until `items.length >= total`.

