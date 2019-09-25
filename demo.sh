#!/bin/bash

# Print message
echo This is an echo message.

# Print current working directory
pwd

# List all files recursively
ls -Rla

# Make a directory
mkdir test_dir

# Delete a directory
rm -rf test_dir


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
      echo "[]" > ./$TEST_DIR/$f
   done
fi

ls -R
