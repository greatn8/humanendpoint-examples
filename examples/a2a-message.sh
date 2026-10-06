#!/usr/bin/env bash
set -euo pipefail

curl -sS -X POST https://humanendpoint.au/a2a \
  -H "Content-Type: application/json" \
  -d '{
    "jsonrpc": "2.0",
    "id": 1,
    "method": "message/send",
    "params": {
      "message": {
        "role": "user",
        "parts": [
          {
            "kind": "text",
            "text": "What human capabilities can you provide for a task that requires calling a supplier?"
          }
        ]
      }
    }
  }'
