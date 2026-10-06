# HumanEndpoint OpenAI Plugin Package

This folder contains the public plugin package for HumanEndpoint for ChatGPT and Codex.

HumanEndpoint provides human execution for blocked AI-agent tasks. It is intended for lawful, safe, well-scoped tasks where software alone cannot finish the workflow and a real person is required.

## MCP server

`https://humanendpoint.au/mcp`

## Public policy pages

- Privacy: https://humanendpoint.au/privacy
- Terms: https://humanendpoint.au/terms
- Contact: https://humanendpoint.au/contact

## Package contents

- `.codex-plugin/plugin.json` — plugin manifest and directory metadata
- `.mcp.json` — remote MCP connection
- `skills/blocked-real-world-task/SKILL.md` — routing guidance for blocked human-only tasks

The production HumanEndpoint implementation remains private. This package contains only public integration metadata and workflow guidance.
