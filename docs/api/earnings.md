# Earnings API

All endpoints require an `Authorization: Bearer <jwt>` header.

## RBAC rules

- **Employee users** can only access earnings for their own `:userEmail`.
- **Admin users** can access earnings for any `:userEmail`.
- **Pay rate updates** are **admin-only**.

## Get earnings summary

`GET /api/earnings/summary/:userEmail?startDate=YYYY-MM-DD&endDate=YYYY-MM-DD`

**Success response**

```json
{
  "success": true,
  "data": {
    "totalHours": 12.5,
    "totalEarnings": 987.5,
    "payRate": 79,
    "payType": "Hourly",
    "history": [
      { "date": "2026-01-01", "hours": 2.5, "earnings": 197.5 }
    ]
  }
}
```

## Get projected earnings

`GET /api/earnings/projected/:userEmail?startDate=YYYY-MM-DD`

**Success response**

```json
{
  "success": true,
  "data": {
    "projectedHours": 10,
    "projectedEarnings": 790,
    "breakdown": [
      {
        "date": "2026-01-15",
        "clientEmail": "client@example.com",
        "hours": 2,
        "earnings": 158
      }
    ]
  }
}
```

## Get earnings history (bucketed)

`GET /api/earnings/history/:userEmail?startDate=YYYY-MM-DD&endDate=YYYY-MM-DD&bucket=week|month`

**Notes**

- `bucket=week` groups by Monday–Sunday week.
- `bucket=month` groups by calendar month.

**Success response**

```json
{
  "success": true,
  "data": {
    "bucket": "month",
    "payRate": 79,
    "items": [
      {
        "periodStart": "2026-01-01",
        "periodEnd": "2026-01-31",
        "hours": 12.5,
        "earnings": 987.5
      }
    ]
  }
}
```

## Set pay rate (admin-only)

`POST /api/earnings/rate/:userEmail`

**Body**

```json
{
  "rate": 79,
  "type": "Hourly"
}
```

**Success response**

```json
{
  "success": true,
  "message": "Pay rate updated"
}
```

