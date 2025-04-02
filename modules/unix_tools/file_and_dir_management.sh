#!/usr/bin/env bash

# File and Directory Management Tools

# These commands are used to manage files and directories, such as creating, deleting, copying, moving, and listing files.
# Examples:
# ls, cp, mv, rm, mkdir, rmdir, find, touch, stat, tree, rsync, ln

file_and_dir_management_tools_demo() {
    DIR_DEMO_DIR=dir_demo
    mkdir "$DIR_DEMO_DIR"

    # Print current working directory
    pwd

    # List all files recursively
    ls -Rla

    # Make a directory
    mkdir test_dir

    # Delete a directory
    rm -rf test_dir

    rm -rf a/b//c/test_dir
    # Create directory and all its parents
    mkdir -p a/b/c/test_dir

    # Check if directory exists
    TEST_DIR=test_dir

    if [ -d $TEST_DIR ]; then
    echo Directory $TEST_DIR exists.
    else
    echo Directory $TEST_DIR does not exist.
    mkdir $TEST_DIR

    FILES="test_file_01.txt
    test_file_02.txt
    test_file_03.txt"

    for f in $FILES
    do
        echo "Processing $f"
        echo "[]" > "./$TEST_DIR/$f"
    done
    fi

    ls -RDIR_DEMO_DEST_DIR

    # Copying files from source dir to target dir with same name
    DIR_DEMO_SOURCE_DIR=$DIR_DEMO_DIR/source/content
    DIR_DEMO_DEST_DIR=$DIR_DEMO_DIR/dest/content

    mkdir -p $DIR_DEMO_SOURCE_DIR
    mkdir -p $DIR_DEMO_DEST_DIR

    touch $DIR_DEMO_SOURCE_DIR/source_file_{1..5}
    touch $DIR_DEMO_DEST_DIR/dest_file_{1..5}

    # this creates /dest/content/content/
    # cp -r $DIR_DEMO_SOURCE_DIR $DIR_DEMO_DEST_DIR

    # this copies all files from source/content/ to /dest/content/
    cp -r $DIR_DEMO_SOURCE_DIR/* $DIR_DEMO_DEST_DIR

    # Use --preserve=links -r to copy directories recursively and to preserve symlinks
    # cp --preserve=links -r $DIR_DEMO_SOURCE_DIR/* $DIR_DEMO_DEST_DIR
}

rsync_demo() {
    RSYNC_SOURCE_DIR=rsync/source/
    RSYNC_DEST_DIR=rsync/dest/

    rm -rf "$RSYNC_SOURCE_DIR"
    rm -rf "$RSYNC_DEST_DIR"

    mkdir -p "$RSYNC_SOURCE_DIR"
    mkdir -p "$RSYNC_DEST_DIR"

    touch "$RSYNC_SOURCE_DIR"/source_file_{1..5}
    touch "$RSYNC_DEST_DIR"/dest_file_{1..5}

    # -r = recursive, which is necessary for directory syncing
    # -a = archive; syncs recursively (so -r is not necessary here) and preserves symbolic links, special and device files, modification times, group, owner, and permissions
    #      It is more commonly used than -r and is usually what you want to use.
    # --ignore-existing = skip updating files that exist on receiver
    rsync -a --verbose --ignore-existing "$RSYNC_SOURCE_DIR" "$RSYNC_DEST_DIR"
}

ln_demo() {
    SYMLINK_DEMO_DIR=symlink

    rm -rf $SYMLINK_DEMO_DIR

    SYMLINK_DIR_ORIG=$SYMLINK_DEMO_DIR/orig
    SYMLINK_DIR_LINKS=$SYMLINK_DEMO_DIR/links
    SYMLINK_DIR_LINKS_COPY=$SYMLINK_DEMO_DIR/links_copy

    mkdir -p $SYMLINK_DIR_ORIG
    mkdir -p $SYMLINK_DIR_LINKS

    # Create original dir and file
    mkdir $SYMLINK_DIR_ORIG/mydir
    touch $SYMLINK_DIR_ORIG/mydir/dummy_file
    touch $SYMLINK_DIR_ORIG/myfile

    # Create symlinks
    # ln = creates links which can be hard and symbolic
    # -s (--symbolic) = creates symbolic link

    # This will create symlink pointing to non-existing file!
    # ln -s $SYMLINK_DIR_ORIG/myfile $SYMLINK_DIR_LINKS/myfile

    # https://unix.stackexchange.com/questions/10370/make-a-symbolic-link-to-a-relative-pathname
    # "at the time the symlink is being used and resolved, that string is understood as a relative path to the parent directory of the symlink (when it doesn't start with /).""
    ln -s ../orig/myfile $SYMLINK_DIR_LINKS/myfile
    readlink -v $SYMLINK_DIR_LINKS/myfile

    ln -s ../orig/mydir $SYMLINK_DIR_LINKS/mydir
    readlink -v $SYMLINK_DIR_LINKS/mydir

    ls -lt $SYMLINK_DIR_LINKS

    # Copying directory which contains symlinks
    # --preserve[=ATTR_LIST] = preserve the specified attributes (default:mode,ownership,timestamps), if possible additional attributes: context, links, xattr, all
    # -r (-R, --recursive) = copy directories recursively
    cp --preserve=links -r $SYMLINK_DIR_LINKS $SYMLINK_DIR_LINKS_COPY
}

dirname_demo() {
    # Print the directory name of a path
    echo "dirname /usr/bin/ls: $(dirname /usr/bin/ls)"

    # get the directory where the script is located (but not the full path)
    CURRENT_DIR=$(dirname "$0")
    echo "📂 Current directory: $CURRENT_DIR"

    

    # Get the directory where the script is located
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    log_info "📂 Script directory (full path): $SCRIPT_DIR"
}
