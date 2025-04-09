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

* [Variables](#variables)
* [Special variables](#special_variables)
* [Variable expansion](#variable_expansion)
* [Parameter expansion expression](#parameter_expansion_expression)
* [Loading variables from .env file](#loading-variables-from-env-file)
* [Command substitution](#command-substitution)
* [Globbing](#globbing)
* [Bash built-in commands](#bash-built-in-commands)
    * [declare](#declare)
    * [echo](#echo)
    * [printf](#printf)
    * [read](#read)
    * [set](#set)
    * [shift](#shift)
    * [test](#test)
* [Unix Tools](#unix-tools-unix-core-utilities)
    * [head](#head)
* [Misc](#misc)

<a id="variables"></a>
## Variables

Avoid using these namnes for variables as these are the names of special environment variables in Bash and Unix-like systems. These variables are critical for the functioning of the shell and the system, and overwriting them without care can lead to unexpected behavior.

```
BASH_VERSION
CDPATH
COLUMNS
DISPLAY
EDITOR
ENV
ERREXIT
HISTCONTROL
HISTFILE
HISTFILESIZE
HISTIGNORE
HISTSIZE
HOME
HOSTNAME
IFS
LANG
LC_ALL
LC_COLLATE
LC_CTYPE
LC_MESSAGES
LC_MONETARY
LC_NUMERIC
LC_TIME
LINES
LOGNAME
MACHTYPE
MAIL
MAILCHECK
MANPATH
OLDPWD
OSTYPE
PAGER
PATH
PATH_SEPARATOR
PROMPT_COMMAND
PROMPT_DIRTRIM
PS1
PS2
PWD
RANDOM
SECURE_PATH
SHELL
SHLVL
TERM
TMPDIR
UID
USER
VISUAL
XDG_CACHE_HOME
XDG_CONFIG_HOME
XDG_DATA_HOME
```

Example of the Problem

Overwriting `PATH`:

```
#!/usr/bin/env bash

# Overwrite PATH
PATH="/some/custom/path"

# Try running a command
echo "This will fail: $(which curl)"
```

Output:

```
which: command not found
```

The shell cannot find the `which` command because `bin` (or other standard directories) is no longer in `PATH`.

### Best Practices:

1. Use a Different Variable Name
Instead of naming your variable `PATH`, use a more descriptive name that avoids conflicts with the system variable. For example:
```
local api_path="/${API_VERSON}/${ENDPOINT}"
```

2. Always Preserve the Original `PATH`
If you must modify `PATH` temporarily, ensure you restore it afterward:
```
original_path="$PATH"
PATH="/some/custom/path:$PATH"

# Run commands here

PATH="$original_path" # Restore the original PATH
```

3. Debugging Tip
If you suspect `PATH` has been overwritten, you can print its value to debug:
```
echo "PATH: $PATH"
```



<a id="special_variables"></a>
## Special variables

"$@"

In Bash, "$@" is a special variable that represents all the positional parameters (arguments) passed to a script or function. Its behavior depends on the context in which it is used: the global scope (outside any function) or within a function.

"$@" in the Global Scope

In the global scope, "$@" represents all the arguments passed to the script when it was executed.
Each argument is treated as a separate, quoted string, preserving spaces and special characters.
"$@" ensures that each argument is treated as a separate entity, even if it contains spaces or special characters.
In the global scope, "$@" refers to the arguments passed to the script.

```
#!/usr/bin/env bash

echo "Global scope:"
echo "All arguments: $@"
echo "Quoted arguments: $@"
echo "Quoted arguments with \"$@\":"
for arg in "$@"; do
    echo "$arg"
done
```

"$@" in a Function

Inside a function, "$@" represents all the arguments passed to that specific function, not the script.
Each argument passed to the function is treated as a separate, quoted string.

```
#!/usr/bin/env bash

my_function() {
    echo "Inside function:"
    echo "All arguments: $@"
    echo "Quoted arguments with \"$@\":"
    for arg in "$@"; do
        echo "$arg"
    done
}

my_function arg1 "arg 2" arg3
```

"$@" in the main Function

```
main "$@"
```

Here, "$@" in the global scope is passed as arguments to the main function.
Inside the main function, "$@" will represent the same arguments that were passed to the script.

Difference Between "$@" and $@

"$@": Each argument is treated as a separate, quoted string. This is the recommended way to handle arguments.
$@: All arguments are treated as a single unquoted string, which can lead to issues with spaces or special characters.

```
#!/usr/bin/env bash

echo "Using \$@:"
for arg in $@; do
    echo "$arg"
done

echo "Using \"\$@\":"
for arg in "$@"; do
    echo "$arg"
done
```

Command:
```
./script.sh arg1 "arg 2" arg3
```

Output:

```
Using $@:
arg1
arg
2
arg3
Using "$@":
arg1
arg 2
arg3
```

`$#` represents the total number of arguments passed to the script.

<a id="variable_expansion"></a>
## Variable expansion

Double quotes are crucial for variable expansion because they allow the shell to interpret and substitute the values of variables within a string, while single quotes treat everything literally.

Double quotes enable the shell to look for and replace variable placeholders (like `$variable`) with their actual values.
Single quotes, on the other hand, treat everything inside them as a literal string, meaning variables are not expanded, and special characters retain their literal meaning.

`echo "Hello, $USER"` will output `"Hello, your_username"` (assuming your username is `your_username`) because the shell expands `$USER`.
`echo 'Hello, $USER'` will output `"Hello, $USER"` because the shell treats `$USER` literally.

It's generally good practice to always double-quote variables when using them in commands or scripts to avoid potential issues with word splitting and ensure the correct interpretation of the variable's value.

`ls -l $PATH` might list files in each directory in `$PATH` if `$PATH` contains spaces, rather than listing the directory itself.
`ls -l "$PATH"` will list the files in the directory `$PATH` as a single argument, regardless of spaces.

<a id="parameter_expansion_expression"></a>
## Parameter expansion expression

```
VAR="${VAR:-default_value}"
```

If `VAR` is already set in the environment (e.g., via `export VAR=value`), it stays unchanged.

If it’s not set, then `VAR` becomes an empty string (`""`), preventing it from being unset/null later in the script.

## Loading variables from .env file

If env file is under our control, we can use:

```
if [[ -f "$ENV_FILE" ]]; then
  set -a  # auto-export all sourced vars
  source "$ENV_FILE"
  set +a # Turn off auto-export to avoid affecting the rest of the script
fi

# Now all variables from .env are automatically available
echo "Username: $USERNAME"
echo "Password: $PASSWORD"
```

Pros:
* Supports KEY="value with spaces"
* Supports escaped characters, multi-line, etc.
* Values are immediately available in your script

Cons:
* Executes any code in the file (e.g., rm -rf 😱)
* Needs properly formatted Bash-compatible syntax

Use when:
* You trust the file (e.g., you wrote it, it's part of your project)
* You need support for strings with quotes/spaces


If env file is not under our control, it is safer to use:
```
export $(grep -v '^#' "$ENV_FILE" | xargs)
```

This command performs the followint:

1)Filters Comments:
`grep -v '^#' "$ENV_FILE"` removes lines starting with `#` (comments) from the environment file `$ENV_FILE`.

2) Trims Whitespace:
`xargs` removes extra spaces, newlines, or trailing/leading whitespace from the filtered lines.

3) Exports Variables:
`export $(...)` evaluates the cleaned output as space-separated key-value pairs and exports them as environment variables.

Example input env file:
```
# Database settings
DB_HOST=localhost
DB_PORT=5432
# API keys
API_KEY=secret123
```

Resulting shell environment:

```
export DB_HOST=localhost
export DB_PORT=5432
export API_KEY=secret123
```

This is a safer, more limited method that only parses lines like KEY=value.

Pros:
* Won’t run arbitrary code
* Works with simple .env files
* Ignores comments

Cons:
* Chokes on values with spaces or quotes
* Doesn’t support KEY="foo bar" properly
* Doesn't support multi-line

Use when:
* You want a safe, simple one-liner
* You're sure the file has clean KEY=value lines only


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

Bash Built-ins:

Commands that are built into the Bash shell itself.
Executed directly by the shell without invoking an external program.
Examples: echo, read, set, shift, test, declare.


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

#### How to Check if a Command Is a Built-in or Unix Tool

1) Using type:

Run type head to check if head is a built-in or an external command.

```
type head
head is /usr/bin/head
```

2) Using which:

Run which head to find the location of the head command.

```
which head
/usr/bin/head
```

3) Using help:

Built-in commands can be checked with help. If help head returns an error, it is not a built-in.


```
help head
bash: help: no help topics match 'head'. Try 'help help'.
```

### declare

Declares the type of the variable explicitly.

```
declare -i my_var # integer
declare -a my_var # indexed array
declare -A my_var # associative array
```

In a function, `declare` makes the variable local (in the function).
Without any name, it lists all variables.

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

### set

The set command is used to modify shell options or positional parameters.
When used with --, it stops interpreting options (flags) and treats everything that follows as arguments.

The -- is a special argument that tells set to stop processing options. This ensures that any arguments following -- are treated as literal arguments, even if they start with a - (which would normally be interpreted as an option).

```
set -- arg1 arg2 arg3 arg4
for ((i=1; i<=$#; i++)); do
    echo "Argument $i: ${!i}"
    shift
done
```

`set -a` command in Bash is used to automatically export all variables defined in the script or sourced file. Essentially, it sets the export flag for each variable, meaning that the variable becomes available to any child processes or subshells.

When you run `set -a`, any variable you assign will automatically be marked for `export`, without needing to explicitly call `export`:

```
set -a   # Enable auto-export for all variables

MY_VAR="hello"
# MY_VAR is now exported without needing `export`

set +a   # Disable auto-export for variables
```


#### How it's useful in loading .env files?

When sourcing a `.env` file, we often want to automatically export all variables so they can be accessed in the script or any subshells. By running `set -a`, any key-value pairs defined in the `.env` file will be automatically exported.

Example:
```
set -a  # Automatically export all variables

# Source the .env file
source .env

set +a  # Turn off automatic export
```

Without `set -a`, we'd have to manually export each variable in the `.env` file, which would be tedious.

### shift

Usually used in while loop which processes arguments.

`shift` - Move to the next argument
`shift 2` - Move 2 arguments (to the one after the next one)

shift command does not work as expected in the loop for ((i=1; i=$#; i++)). This is because shift modifies the positional parameters ($@ and $#) by removing the first argument, but the for ((i=1; i=$#; i++)) loop relies on the original value of $# (the number of arguments) and does not dynamically adjust to the changes caused by shift.

```
set -- arg1 arg2 arg3 arg4
for ((i=1; i<=$#; i++)); do
    echo "Argument $i: ${!i}"
    shift
done
```

Expected output:
```
Argument 1: arg1
Argument 2: arg2
Argument 3: arg3
Argument 4: arg4
```

Actual Output:
```
Argument 1: arg1
Argument 2: arg3
```

After the first shift, arg2 is removed, and the positional parameters are renumbered. The loop skips arg2 and moves directly to arg3.

Fix: If you need to use shift to process arguments, you should use a while loop instead of a for loop. The while loop dynamically adjusts to the changes caused by shift.

```
while [[ $# -gt 0 ]]; do
    echo "Argument: $1"
    shift
done
```



### test

[[ ... ]]:

This is a conditional expression in Bash. The [[ ... ]] construct is used for advanced conditional tests, offering more features and better syntax than the older [ ... ] construct.

`if [[ "${!i}" == "-e" || "${!i}" == "--env-file" ]]; then` - note that there MUST be a SPACE between brackets and nearest token.


-z:

The -z operator checks if the length of a string is zero. It returns true if the string is empty or unset.

## Unix Tools (Unix Core Utilities)

Unix Tools:

* External programs or utilities provided by the operating system.
* Found in directories like bin, bin, or bin.
* Examples: head, tail, grep, awk, sed.

### head


The head command is a Unix tool, not a Bash built-in command. It is part of the core utilities provided by the operating system, typically found in packages like GNU Coreutils on Linux systems or BSD Core Utilities on macOS.

`head -n 5` would display the first 5 lines of input.

On MacOS the command above gives:
```
head: illegal line count -- -1
```

On macOS, `head -n -1` is not supported. To exclude the last line of input, you can use `sed '$d'` or `awk 'NR < NR-1'`. For example:

```
echo "$response" | awk 'NR==1{print; exit}'
```

### tail

The tail command is typically used to display the last few lines of a file or input. By default, it shows the last 10 lines unless otherwise specified.

tail -n 1 command in Bash is used to display the last line of input. The -n option allows you to specify the number of lines to display. In this case, -n 1 tells tail to display only the last line of the input. This is particularly useful when you need to extract a specific piece of information from the end of a file or stream.


Monitoring Logs:

While tail is often used with the -f option to follow logs in real-time, tail -n 1 can be used to quickly check the most recent log entry.

## Misc

`${ENV_FILE}`

This refers to the value of the ENV_FILE variable. The `${}` syntax is used to safely reference variables in Bash, especially when concatenating or using special characters.

`;`

The semicolon (;) marks the end of the condition. It is required when the then keyword or the body of the if statement is placed on the next line.

The `${!i}` syntax retrieves the value of the i-th positional parameter.

`for ((i=1; i<>=$#; i++)):` - This is a C-style for loop in Bash.