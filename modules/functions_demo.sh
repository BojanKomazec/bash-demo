# Don't use a function keyword to define a bash function. That would make it less portable.

# Everything echo-ed that should not be reuturned needs to be directed to stderr.
fun_returns_string() {
    echo "fun_returns_string()"
    echo "This will go to stderr" >&2
    echo "Is this the only returned string?"
}

# $(cmd) captures everything that goes to stdout from cmd
capture_fun_return_val() {
    ret_val="$(fun_returns_string)"
    echo "Function returned: $ret_val"
}

functions_demo() {
    capture_fun_return_val
}