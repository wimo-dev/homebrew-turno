# homebrew-turno

Homebrew tap for [turno](https://github.com/wimo-dev/turno): one MCP gateway and
per-folder accounts for Claude Code, Codex, Copilot CLI and Cursor CLI.

```sh
brew tap wimo-dev/turno
brew trust wimo-dev/turno   # Homebrew 7 asks before loading third-party taps
brew install turno
```

The formula installs the `turno-cli` package from npm and needs Node, which Homebrew installs
for you. Upgrade with `brew upgrade turno`.
