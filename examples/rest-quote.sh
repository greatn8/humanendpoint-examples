#!/usr/bin/env bash
set -euo pipefail

BASE_URL="https://humanendpoint.au"

curl -sS -X POST "$BASE_URL/v1/quotes" \
  -H "Content-Type: application/json" \
  -d '{
    "service_slug": "phone-enquiry",
    "objective": "Call the supplier and confirm current stock, price and lead time for Product X.",
    "deliverables": [
      "Current stock status",
      "Current price",
      "Current lead time"
    ],
    "max_budget_usdc": 10,
    "max_expenses_usdc": 0,
    "callback_url": "https://agent.example.com/humanendpoint/quote-events"
  }'
