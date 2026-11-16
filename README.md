# homebrew-turno

Homebrew tap for [turno](https://github.com/william-monroy/turno): one MCP gateway and
per-folder accounts for Claude Code, Codex, Copilot CLI and Cursor CLI.

```sh
brew tap william-monroy/turno
brew trust william-monroy/turno   # Homebrew 7 asks before loading third-party taps
brew install turno
```

The formula installs the `turno-cli` package from npm and needs Node, which Homebrew installs
for you. Upgrade with `brew upgrade turno`.
