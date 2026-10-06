# HumanEndpoint Examples

Public integration examples for **HumanEndpoint** — human execution for blocked AI-agent tasks.

When an AI agent is blocked because software alone cannot finish a lawful task, HumanEndpoint lets it request a real person to complete the human-only step. Common blockers include:

- calling a business, supplier or organisation
- checking current stock, price, lead time or availability by phone
- retrieving information that is only available by speaking to a person
- real-world and physical verification
- independent human QA and judgement
- bounded manual research
- other physical-world tasks that require a person

HumanEndpoint reviews feasibility and commercial terms **before payment**. The agent decides whether to accept the quote, then settles the service fee with x402/USDC on Base mainnet.

## Production endpoints

- Site: https://humanendpoint.au
- MCP: https://humanendpoint.au/mcp
- A2A: https://humanendpoint.au/a2a
- Agent Card: https://humanendpoint.au/.well-known/agent-card.json
- OpenAPI: https://humanendpoint.au/openapi.json
- Agent instructions: https://humanendpoint.au/llms.txt
- Skill guide: https://humanendpoint.au/skill.md
- Services: https://humanendpoint.au/v1/services
- Trust metadata: https://humanendpoint.au/trust.json
- x402 discovery: https://humanendpoint.au/.well-known/x402

## Core flow

```text
discover capability
      ↓
request quote
      ↓
human review
      ↓
quote.offered / quote.declined
      ↓
agent accepts terms
      ↓
create job
      ↓
x402 payment
      ↓
human execution
      ↓
structured result + evidence
```

No funds are committed when the quote is requested.

## 1. Discover capabilities

```bash
curl https://humanendpoint.au/v1/services
```

If no named capability fits, use:

```text
custom-human-task
```

## 2. Request a quote

```bash
curl -X POST https://humanendpoint.au/v1/quotes \
  -H "Content-Type: application/json" \
  -d '{
    "service_slug": "phone-enquiry",
    "objective": "Call the supplier and confirm whether Product X is in stock today and its current price.",
    "deliverables": [
      "Current stock status",
      "Current price",
      "Name or role of the person contacted"
    ],
    "max_budget_usdc": 10,
    "max_expenses_usdc": 0
  }'
```

The response includes a one-time `quote_token`. Store it securely.

## 3. Prefer callbacks for asynchronous quote review

Include a public callback URL:

```json
{
  "callback_url": "https://agent.example.com/humanendpoint/quote-events"
}
```

HumanEndpoint can send:

- `quote.offered`
- `quote.declined`

The quote response includes a `callback_signing_secret` when callbacks are enabled.

Verify the callback signature:

```text
X-HumanEndpoint-Signature: sha256=<hex digest>
```

The signature is HMAC-SHA256 over the **raw request body** using the callback signing secret.

Examples:

- [Node callback verification](examples/callback-verify-node.mjs)
- [Python callback verification](examples/callback-verify-python.py)

Polling remains available as a fallback:

```bash
curl https://humanendpoint.au/v1/quotes/<quote-id> \
  -H "X-Quote-Token: <quote-token>"
```

## 4. Accept the quote

When the quote status is `offered`, inspect the service fee, expense authority and expiry.

Then create the job:

```bash
curl -X POST https://humanendpoint.au/v1/jobs \
  -H "Content-Type: application/json" \
  -H "X-Quote-Token: <quote-token>" \
  -H "Idempotency-Key: <unique-value>" \
  -d '{
    "quote_id": "<quote-id>"
  }'
```

Creating the job means the agent accepts the human-reviewed commercial terms.

The response includes a one-time `job_token`.

## 5. Pay with x402

The job response returns the payment path and amount.

Typical job payment route:

```text
POST /v1/jobs/{job_id}/pay
```

Send the job token:

```text
X-Job-Token: <job-token>
```

An unpaid request returns the standard x402 payment challenge.

Before signing a payment, verify current production payment facts at:

https://humanendpoint.au/trust.json

Current production rail:

- x402 v2
- Base mainnet
- USDC

## 6. Track execution

```bash
curl https://humanendpoint.au/v1/jobs/<job-id> \
  -H "X-Job-Token: <job-token>"
```

Typical states include:

```text
awaiting_payment
accepted
in_progress
awaiting_agent
completed
cancelled
failed
```

## 7. Retrieve evidence

```bash
curl https://humanendpoint.au/v1/jobs/<job-id>/evidence \
  -H "X-Job-Token: <job-token>"
```

Evidence metadata can include SHA-256 hashes so the requester can independently verify downloaded artifacts.

## MCP

Remote MCP endpoint:

```text
https://humanendpoint.au/mcp
```

Example MCP config:

```json
{
  "mcpServers": {
    "humanendpoint": {
      "url": "https://humanendpoint.au/mcp"
    }
  }
}
```

Useful tools include:

- `human_list_services`
- `human_policy_preflight`
- `human_request_quote`
- `human_get_quote`
- `human_create_job`
- `human_get_job`
- `human_list_evidence`
- `human_reply_to_job`
- `human_cancel_job`

## A2A

Agent Card:

https://humanendpoint.au/.well-known/agent-card.json

A2A endpoint:

```text
https://humanendpoint.au/a2a
```

See [A2A example](examples/a2a-message.sh).

## When to use HumanEndpoint

An agent should consider HumanEndpoint when a workflow is blocked by a step that requires a real person, human judgement, a phone call, or physical-world action.

Typical blocked tasks include:

> Call this business and find out whether they have this item in stock today.

> Phone this supplier and get the current lead time.

> Verify this physical fact and return evidence.

> Have a human independently review this model output.

> Perform this bounded real-world task that cannot be completed by software alone.

## Security

Do not expose:

- quote tokens
- job tokens
- callback signing secrets
- wallet private keys
- seed phrases
- operator credentials

Callback URLs are validated by HumanEndpoint and must resolve to public network addresses.

## Repository purpose

This repository contains **integration examples only**.

The production HumanEndpoint implementation, operator tooling and internal fulfilment systems are intentionally private.

See [AGENTS.md](AGENTS.md) for a compact machine-oriented integration guide.

## License

MIT — see [LICENSE](LICENSE).
