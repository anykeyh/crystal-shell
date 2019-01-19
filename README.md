# Crystal Shell

1. During installation, will add `crystal_shell` binary into `/usr/local/bin`
2. Create shell script adding shebang `#!/usr/bin/env crystal_shell` and `chmod +x` any file you want.
3. Write your crystal script. Call your script through terminal.
4. It's slow the first call, but it automatically compile in background with `--release` flags
5. Wow, blazing after few seconds as it's compiled (-:

## Installation

```bash
\curl -sSL https://raw.githubusercontent.com/anykeyh/crystal-shell/master/install.sh | bash -s stable
```

## Maintenance

Compiled binary version are stored in `~/.cache/crystal_shell` directory

- You can delete the files there by calling `crystal_shell --prune`
- You may want to ~break my heart~ remove the binary by calling `crystall_shell --uninstall`

## Example

Assuming you wrote `test.sh`:

```crystal
#!/bin/env crystal_shell

puts "I'm slow at first, but sooooo fast later one :D"
```

Then:
```bash
$ chmod +x test.sh
```

Finally:
```
$ time ./test.sh
I'm slow at first, but sooooo fast later one ;)

real  0m1.132s
user  0m1.875s
sys 0m0.424s
$ ... (wait few seconds, ok buddy?)
$ time ./test.sh
I'm slow at first, but sooooo fast later one ;)

real  0m0.034s
user  0m0.010s
sys 0m0.018s
```

## Caveats

- Need curl to install automatically. But curl is everywhere, except maybe on busybox?

- Crystal-shell use MD5 hash of file you try to execute. Therefore, f your script require library, it may not catch the change in the file required.

- This tool is mainly focused on simple scripts which should run fast.

- I use it for managing my bash session (e.g. showing git branch, checking language of the current directory, displaying current version of the language compiler I'm using etc etc...) as performance matters when you stack up all this features ;-)

## Licence

Release under [DBAD](https://dbad-license.org/) Licence.