# Crystal Shell

1. Add `crystal_shell` binary into `/usr/local/bin`
2. Create shell script adding shebang `#!/usr/bin/env crystal_shell` and `chmod +x` your file
3. Call your script.
4. Slow the first call, but automatically compile in background with `--release` flags
5. Wow, blazing the second call as it's compiled (-:

## Installation

```bash
\curl -sSL https://raw.githubusercontent.com/anykeyh/crystal-shell/master/install.sh | bash -s stable
```

## Maintenance

Compiled binary version are stored in `~/.cache/crystal_shell` directory

- You can delete the files there by calling `crystal_shell --prune`
- You may want to ~break my heart~ remove the binary by calling `crystall_shell --uninstall`