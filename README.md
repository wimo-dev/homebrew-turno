# homebrew-turno

Homebrew tap for [turno](https://github.com/wimo-dev/turno): one MCP gateway and
per-folder accounts for Claude Code, Codex, Copilot CLI and Cursor CLI.

```sh
brew tap wimo-dev/turno
brew trust wimo-dev/turno   # Homebrew 7 asks before loading third-party taps
brew install turno
```

The formula installs the `turno-cli` package from npm and needs Node, which Homebrew installs
for you. It runs `npm ci` against the `npm-shrinkwrap.json` the package ships, so you get
exactly the dependency tree that turno's CI tested, and no install scripts run. Upgrade with
`brew upgrade turno` (or `turno upgrade`, which runs it).

The `formula` workflow audits the formula (`brew audit --strict --online`), builds it from
source and runs its test on macOS and Linux for every pull request.
