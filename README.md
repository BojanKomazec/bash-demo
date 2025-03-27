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