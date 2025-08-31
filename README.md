# Codex MCP Starter Project

This repository is a ready‑made scaffold for using **Codex CLI** with a suite of
Model Context Protocol (MCP) servers to enable powerful agentic coding
experiences in the terminal. It bundles configuration and helper scripts so
that you can get started quickly without having to piece together the
requirements yourself.

## Included MCP servers

The `.codex/config.toml` file defines four MCP servers that run via
STDIO. Each server enhances the capabilities of Codex:

| Server       | Purpose                                                                                            |
|-------------|----------------------------------------------------------------------------------------------------|
| **filesystem** | Exposes the local filesystem so Codex can read directory structures, file contents and metadata. |
| **ripgrep**    | Provides fast full‑text search across your project using ripgrep.                                 |
| **memory**     | Adds persistent memory stored in `memory/memory.jsonl` so the agent can recall past actions.    |
| **git**        | Enables secure Git operations (status, diff, commit, branch, etc.) through an MCP interface.    |

You can add or remove servers by editing the `mcp_servers` section in
`.codex/config.toml`. Additional servers such as language‑server bridges or
security scanners can be integrated by adding their `command` and `args`
definitions.

## Getting started

### 1. Install dependencies

Run the helper script to install required packages:

```bash
./scripts/install_mcp.sh
```

This script ensures that ripgrep and the Codex CLI are present. It also
implicitly fetches the MCP server packages via `npx` the first time you run
Codex.

> Note: You need Node.js and npm installed. On Debian/Ubuntu you can install
> them with `sudo apt-get install nodejs npm`. On macOS use Homebrew or a
> package manager of your choice.

### 2. Launch Codex CLI

To start working with Codex in this repository, run:

```bash
./scripts/run_codex.sh
```

Codex will read `.codex/config.toml`, launch the MCP servers via STDIO and
enter its interactive agent interface. By default it runs in **Auto** mode,
allowing the agent to read and write files inside the project while
prompting for confirmation before running external commands or making
network requests.

You can switch approval modes inside Codex using the `/approvals` command.
For day‑to‑day work keep the default **Auto** or **Read Only** modes. Only
enable **Full Access** in a secure, isolated environment as it removes
approval prompts for sensitive operations.

### 3. Persisting memory

The knowledge‑graph memory server stores persistent state in
`memory/memory.jsonl`. This file lives alongside your code and will be
updated automatically by Codex as you interact. Because the memory store is
within the repository, it will be tracked by Git and will persist across
sessions. You can change its location by modifying the `--memory-path`
argument in `.codex/config.toml`.

### 4. Customizing further

- **Adding LSP/AST servers:** To enrich Codex with language server
  capabilities (hover info, references, renaming) or AST introspection,
  configure additional MCP servers such as `lsp-mcp-server` or
  `tree-sitter-mcp`. Add them to `.codex/config.toml` using the pattern:
  
  ```toml
  [mcp_servers.lsp]
  command = "npx"
  args = ["-y", "lsp-mcp-server@latest"]
  ```

- **Security scanning:** Integrate security analysis tools (e.g. Snyk
  Security) by adding an MCP server entry. Check each tool’s documentation
  for STDIO support and configuration flags.

- **Remote MCP:** Codex CLI officially supports only STDIO servers. If you
  need to connect to remote HTTP/SSE servers, you must run a proxy such as
  `mcp-proxy` to bridge the transport. See the respective server’s README
  for details.

## Notes on security and approvals

Codex CLI operates with different approval modes. When working on a local
project, keep the default **Auto** or **Read Only** modes to prevent
unauthorised changes or network access. Only enable **Full Access** in
sandboxed environments. You can review and adjust the current mode within
Codex by typing `/approvals`.

Also, never expose your memory or MCP servers to an untrusted network. The
`mcp_servers` defined here run via STDIO, which is local to your terminal. If
you experiment with remote transports or run the Inspector UI, ensure
authentication is enabled and do not bind the server to public interfaces.

## License

This scaffold is provided for educational and experimental use. It contains
no proprietary code beyond references to publicly available open‑source
packages. You are free to adapt it to your needs.
