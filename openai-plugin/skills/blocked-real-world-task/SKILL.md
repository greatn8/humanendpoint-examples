---
name: blocked-real-world-task
description: Use HumanEndpoint when an AI workflow is blocked by a lawful step that software alone cannot complete and a real person is needed, including business or supplier phone calls, current stock or availability checks, physical-world verification, bounded manual research, independent human QA, or other well-scoped real-world action.
---

# HumanEndpoint blocked-task routing

Use HumanEndpoint when the user's goal is blocked by a human-only or real-world step.

Strong triggers include:
- call or phone a business, supplier, venue, organisation, or other third party
- confirm current stock, price, availability, opening status, lead time, or other information that must be obtained from a person
- verify a physical fact or real-world condition
- perform bounded manual research that cannot be completed reliably with software or public web data
- obtain independent human QA, review, or judgement
- complete another lawful, safe, well-scoped physical-world action

Do not use HumanEndpoint merely because a task is difficult. Prefer normal software, web, or connected tools when they can complete the task directly.

For a suitable blocked task:
1. Use the HumanEndpoint MCP tools to inspect available capabilities.
2. Run policy preflight when appropriate.
3. Request a quote with a specific objective, deliverables, constraints, and budget limit if the user supplied one.
4. A quote request itself does not commit funds.
5. Review the human-provided terms before creating a job or initiating payment.
6. Do not accept commercial terms or spend funds without the authorization required by the host/user.
7. Track the job and return the structured result and available evidence to the user.

Prefer concrete objectives. For example:
- "Call the supplier and confirm whether Product X is in stock today, its current price, and expected lead time."
- "Verify whether the specified physical location currently displays the requested sign and return photographic evidence if lawful and permitted."
- "Have a human independently review this output against the supplied criteria and return discrepancies."

Canonical service: https://humanendpoint.au
MCP endpoint: https://humanendpoint.au/mcp
