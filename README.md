# bash-demo
A collection of bash shell scripts which demonstrate Bash syntax and common Linux commands and tools.

# Running the script

Make sure `demo.sh` has executable (`x`) permissions for the current user.
To run the script use:
```
./demo.sh
```

All files and directories that are required by the script (which are not created by the script) have to be inside `required` directory.

Use `#!/usr/bin/env bash` shebang instead of `#!/bin/bash`. This way is more portable as we don't assume the bash location (it can be installed at `/usr/local/bin/bash` or, on Mac, at `/opt/homebrew/bin/bash`). env searches for the specified program (bash) in the directories listed in the user's `PATH` environment variable. This ensures that the correct version of bash is executed, even if it is not located in a standard location.

To return a value from funcion, simply assign that value to a dedicated global variable (within a function), call the function without using command substitution (`$()`) (which calls the subshell) and read the value of that global variable into the variable in the calling function. This way you'll avoid going down the rabbit hole of preventing buffering of subshell which adds complexity for a very little gain.

# Debugging Bash scripts

Start your bash script with `bash -x ./script.sh` or add in your script `set -x` to see debug output.

To localize debugging:
```
set -x

...
code to debug
...

set +x
```

# Controlling script exit conditions

In shell scripting, commands return an exit code (a number) to indicate success or failure. A zero exit code typically means success, while a non-zero code indicates an error.

`set -e` (or `set -o errexit`) in shell scripting causes the entire script to exit immediately if any command, including those within functions, returns a non-zero exit code (indicating an error).

When a function in a shell script executes a command that returns a non-zero exit code (`false` or e.g. `return 1`), and `set -e` is enabled, the script will immediately exit, regardless of where the function is called from or what other commands are in the script.


# Bash Tips and Tricks

## Command substitution

When we use `$(...)`, the command inside the parentheses is executed in a subshell.

A subshell is a separate process, and any variables or changes made inside it do not affect the parent shell.

If the a variable from the calling shell is not properly passed or accessible within the subshell, the command inside $(...) may not behave as expected.

## Globbing

Globbing is a string pattern matching like:

```
if [[ -z "$value" || "$value" == --* || "$value" == -* ]]; then
```

* `--*` means "any string that starts with two dashes (`--`)", like `--verbose`, `--help`, etc.
* `-*` means "any string that starts with one dash (`-`) followed by anything", like `-u`, `-p`, etc

Pattern matching like `--*` only works with double bracked test `[[ ... ]]` (not with single bracket test `[ ... ]`).

## Bash built-in commands

There are several options to see the list of all Bash built-in commands:
* `man builtins`
* `man bash`
* execute `help` in a Bash shell
* execute `compgen -b` in a Bash shell


```
$ compgen -b
.
:
[
alias
bg
bind
break
builtin
caller
cd
command
compgen
complete
compopt
continue
declare
dirs
disown
echo
enable
eval
exec
exit
export
false
fc
fg
getopts
hash
help
history
jobs
kill
let
local
logout
mapfile
popd
printf
pushd
pwd
read
readarray
readonly
return
set
shift
shopt
source
suspend
test
times
trap
true
type
typeset
ulimit
umask
unalias
unset
wait
```

### declare

Declares the type of the variable explicitly.

```
declare -i my_var # integer
declare -a my_var # indexed array
declare -A my_var # associative array
```

In a function, `declare` makes the variable local (in the function).
Without any name, it lists all variables

### echo

`echo` by default adds a new line character.

Redirecting to stderr (>&2) flushes output immediately. If we omit this, the return value will be "foo()". This is a consequence of buffering.
```
foo() {
    echo "foo()" >&2
    echo "This is a desired return value"
}

ret_val=$(foo)
```

Using echo to write the _message_ in a function which also needs to return _data_ comes with buffering traps if everything is redirected to stdout. Messages migth not come in the desired/expected order and the output value might not contain only desired data but also parts of messages. We can return value from a function in multiple ways (via global variable or via file) but the most clean solution comes from the idea that stdin should be used ONLY for data and stderr should be used for any communication with terminal user (prompts, messaging). Messages echo'ed to stderr get flushed immediately so their order is preserved and this also leaves stdin in a clean state, used for communicating pure data between functions. By default, Bash itself writes `read -p` prompts to stderr (https://unix.stackexchange.com/questions/380012/why-does-bash-interactive-shell-by-default-write-its-prompt-and-echoes-its-inter).

From https://stackoverflow.com/questions/79359311/bash-function-call-leads-to-incorrect-reversed-text-output-order#comment139947978_79359398:

> printing the menu to stderr is absolutely a good idea. Stderr is where prompts, logs, and every other human-interaction status or "diagnostic" element belongs; stdout is intended for proper output -- meaning, if you're redirecting your program's output to a file, the things you'd want in that file. Content meant for a human operator to read doesn't fit that description. Take a look at your shell -- bash or what-have-you -- and you'll see its prompts are likewise going to stderr; this is entirely fitting as they're diagnostic in nature, giving the operator status information that the shell is ready for another command to be typed.

`echo -e` enables interpretation of escape sequences like `\n`.

### printf

`printf` does not add a new line by default.

`printf` interprets `\n` as a newline and formats the prompt string correctly.
The backslash-escaped characters are interpreted when used in the format string or in an argument corresponding to a `%b` conversion specifier.


Escape sequence will be interpreted correctly in these cases:
```
printf "Line1\nLine2"
printf "%b" "Line1\nLine2"
```

Escape sequence will not be interpreted correctly (will be printed as is) in these cases:
```
printf "%s" "Line1\nLine2"
```

### read

The `-e` option in the read command enables Readline support, which allows you to use features like:

* Arrow key navigation (move left/right in the input, use up/down to browse history). We can use arrow keys to move the cursor within the input.
* Emacs-style editing (e.g., Ctrl+A to go to the beginning of the line, Ctrl+E for the end).
* Command history search (if properly configured with bind).

Without `-e`, `read` treats input as plain text, meaning:
* Arrow keys print `^[[A`, `^[[B`, `^[[C` or `^[[D` instead of navigating.
* No command history or editing features.

`read` does not interpret escape sequences in prompt message. The workaround is to print the message as `echo -e` or `printf` before the `read`.