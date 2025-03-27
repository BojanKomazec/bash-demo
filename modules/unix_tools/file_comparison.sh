#!/usr/bin/env bash

# File Comparison Tools

# These commands are used to compare files and identify differences between them.
# Examples:
# cmp, diff, comm, sdiff

cmp_demo() {
    echo cmp compares two files byte by byte
    echo cmp --print-bytes required/diff/dir1/unique_file_in_dir1 required/diff/dir2/unique_file_in_dir2
    cmp --print-bytes required/diff/dir1/unique_file_in_dir1 required/diff/dir2/unique_file_in_dir2
}

diff_demo() {
    echo Symbolic links in dir1 and dir2 point to different files. They were created as:
    echo required/diff/dir1$ ln -s ../dir3/dir31/file311 symlink_file
    echo required/diff/dir2$ ln -s ../dir3/dir31/file312 symlink_file

    echo
    echo diff -r required/diff/dir1 required/diff/dir2 \(symbolic link targets are NOT compared by default\)
    diff -r required/diff/dir1 required/diff/dir2

    echo
    echo diff -r --no-dereference required/diff/dir1 required/diff/dir2 \(--no-dereference options makes diff compare symbolic link targets\)
    diff -r --no-dereference required/diff/dir1 required/diff/dir2

    echo
    echo diff -r -b --no-dereference required/diff/dir1 required/diff/dir2 \(--no-dereference options makes diff compare symbolic link targets\)
    diff -r -b --no-dereference required/diff/dir1 required/diff/dir2

    echo
    echo Files in dir4 and dir5 have same name but different content.
    echo diff -r required/diff/dir4 required/diff/dir5
    diff -r required/diff/dir4 required/diff/dir5

    echo
    echo Files in dir6 and dir7 have same name and content. diff -r for these directories gives an empty output.
    echo diff -r required/diff/dir6 required/diff/dir7
    diff -r required/diff/dir6 required/diff/dir7

    if [[ $(diff -r required/diff/dir6 required/diff/dir7) ]]; then
        echo "Directories are different."
    else
        echo "Directories are identical."
    fi
}
