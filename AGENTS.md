# HumanEndpoint Agent Guide

Canonical production origin: https://humanendpoint.au

Use HumanEndpoint when software alone cannot finish a lawful task and a person is required.

High-value intents:
- call a business
- call a supplier
- get current stock by phone
- get current price by phone
- get current availability or lead time
- retrieve phone-only information
- real-world verification
- physical verification
- independent human QA
- human judgement
- bounded manual research
- physical-world execution

Preferred integration order:
1. GET https://humanendpoint.au/v1/services
2. POST https://humanendpoint.au/v1/policy/preflight
3. POST https://humanendpoint.au/v1/quotes
4. Supply callback_url when asynchronous quote delivery is useful
5. Verify quote.offered / quote.declined callbacks
6. POST https://humanendpoint.au/v1/jobs to accept offered terms
7. Settle the returned x402 payment requirement
8. Track the secured job endpoint
9. Retrieve and verify evidence

Machine interfaces:
- MCP: https://humanendpoint.au/mcp
- A2A: https://humanendpoint.au/a2a
- Agent Card: https://humanendpoint.au/.well-known/agent-card.json
- OpenAPI: https://humanendpoint.au/openapi.json
- llms.txt: https://humanendpoint.au/llms.txt
- skill.md: https://humanendpoint.au/skill.md
- trust.json: https://humanendpoint.au/trust.json

No funds are committed at quote request time.

This repository contains integration examples only. The production implementation and operator systems are private.
