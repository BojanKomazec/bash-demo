#!/bin/bash

# Print message
echo This is an echo message.

echo
echo "##################################################################################"
echo Strings demo
echo "##################################################################################"
echo

source ./modules/test_demo.sh
test_demo
exit

echo
echo "##################################################################################"
echo Strings demo
echo "##################################################################################"
echo

source ./modules/strings_demo.sh
string_demo
exit

echo
echo "##################################################################################"
echo cmp demo
echo "##################################################################################"
echo

echo cmp compares two files byte by byte
echo cmp --print-bytes required/diff/dir1/unique_file_in_dir1 required/diff/dir2/unique_file_in_dir2
cmp --print-bytes required/diff/dir1/unique_file_in_dir1 required/diff/dir2/unique_file_in_dir2

# exit 0

echo
echo "##################################################################################"
echo diff demo
echo "##################################################################################"
echo

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

# exit 0

echo
echo "##################################################################################"
echo File actions demo
echo "##################################################################################"
echo

echo test -f \(or [-f ...]\) checks whether file exists and is regular file
echo test -L \(or [-L ...]\) checks whether file exists and is symbolic link
echo test -f required/persons.json

regular_file=required/persons.json
symlink_file=required/diff/dir1/symlink_file

if test -f "$regular_file"; then
   echo "$regular_file" exists and is regular file.
else
   echo "$regular_file" does not exist or is not a regular file.
fi

if test -L "$regular_file"; then
   echo "$regular_file" exists and is symlink file.
else
   echo "$regular_file" does not exist or is not a symlink file.
fi


if test -f "$symlink_file"; then
   echo "$symlink_file" exists and is regular file.
else
   echo "$symlink_file" does not exist or is not a regular file.
fi


if test -L "$symlink_file"; then
   echo "$symlink_file" exists and is symlink file.
else
   echo "$symlink_file" does not exist or is not a symlink file.
fi

# exit 0

echo
echo "##################################################################################"
echo Directory actions demo
echo "##################################################################################"
echo

DIR_DEMO_DIR=dir_demo
mkdir $DIR_DEMO_DIR

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
      echo "[]" > ./$TEST_DIR/$f
   done
fi

TEST_DIR_WITH_SPACES="test dir"

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

echo
echo "##################################################################################"
echo Parsing JSON file demo
echo "##################################################################################"
echo

JSON_FILE=persons.json

echo "grep -Po '\"name\": .*' ./required/\$JSON_FILE"
grep -Po '"name": .*' ./required/$JSON_FILE

echo
echo "grep -Po '\"name\": .*' ./required/\$JSON_FILE | awk -F':' '{print \$2}'"
grep -Po '"name": .*' ./required/$JSON_FILE | awk -F':' '{print $2}'

echo
echo "grep -Po '\"name\": .*?[^\\]\",?' ./required/\$JSON_FILE"
grep -Po '"name": .*?[^\\]",?' ./required/$JSON_FILE

echo
echo "grep -Po '\"name\": .*?[^\\]\"' ./required/\$JSON_FILE | awk -F':' '{print \$2}'"
grep -Po '"name": .*?[^\\]"' ./required/$JSON_FILE | awk -F':' '{print $2}'

echo
echo "grep -Po '\"name\": .*[^,]' ./required/\$JSON_FILE | awk -F':' '{print \$2}'"
grep -Po '"name": .*[^,]' ./required/$JSON_FILE | awk -F':' '{print $2}'

echo
echo "grep -Po '\"surname\": .*[^,]' ./required/\$JSON_FILE | awk -F':' '{print \$2}'"
grep -Po '"surname": .*[^,]' ./required/$JSON_FILE | awk -F':' '{print $2}'

echo
echo Without quotes:
# gsub is used to remove quotes
echo "grep -Po '\"surname\": .*[^,]' ./required/\$JSON_FILE | awk -F':' '{print \$2}'"
grep -Po '"surname": .*[^,]' ./required/$JSON_FILE | awk -F':' '{gsub(/"/, "", $2);print $2}'

echo
echo Without quotes and space at the beginning:
# ': ' is used as separator instead of ':'
echo "grep -Po '\"surname\": .*[^,]' ./required/\$JSON_FILE | awk -F': ' '{print \$2}'"
grep -Po '"surname": .*[^,]' ./required/$JSON_FILE | awk -F': ' '{gsub(/"/, "", $2);print $2}'

echo
echo "##################################################################################"
echo Array demo
echo "##################################################################################"
echo

# Create an array from awk output
names=($(grep -Po '"name": .*[^,]' ./required/$JSON_FILE | awk -F': ' '{gsub(/"/, "", $2);print $2}'))
echo names array:
echo ${names[0]} ${names[1]} ${names[2]}

# Loop through every element in the array
echo names array \(loop\):
for i in "${names[@]}"
do
   :
  echo $i
done

echo Printing array index and value:
for i in "${!names[@]}"; do
  printf "%s\t%s\n" "$i" "${names[$i]}"
done

surnames=($(grep -Po '"surname": .*[^,]' ./required/$JSON_FILE | awk -F': ' '{gsub(/"/, "", $2);print $2}'))

echo Iterating over two arrays of same size:
for i in "${!names[@]}"; do
  printf "%s %s\n" "${names[$i]}" "${surnames[$i]}"
  full_name="${names[$i]} ${surnames[$i]}"
  echo ${full_name}
done

# Find all files with specific extension and in specified directory and put their names in array.
# ./required/ - sets working directory for find command
# -printf '%f\n' - prints only file name (including extension)
names2=($(find ./required/ -type f -path '*dummy_files*/*' -name '*.abc' -printf '%f\n'))
echo Printing names2 array index and value:
for i in "${!names2[@]}"; do
  printf "%s\t%s\n" "$i" "${names2[$i]}"
done


echo
echo "##################################################################################"
echo rsync demo
echo "##################################################################################"
echo

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

echo
echo "##################################################################################"
echo Symbolic links demo
echo "##################################################################################"
echo

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

echo
echo "##################################################################################"
echo Comparing numbers demo
echo "##################################################################################"
echo

number0=0

if [ $number0 == 0 ]; then
   echo "number0 is zero"
else
   echo "number0 is not zero"
fi

if [ $number0 -eq 0 ]; then
   echo "number0 is zero"
else
   echo "number0 is not zero"
fi

# include other bash scripts
source ./modules/file_io.sh
source ./modules/strings_demo.sh
source ./modules/filesystem_demo.sh

# declare a variable to prevent creating XML file
# DISABLE_XML_TO_FILE=dummy_value

# Assigning a value to a variable.
# NOTE: don't insert a space before and after '=' character
xml_file_name=temp.xml

# call a function defined in another bash file included with 'source'
# and pass a variable to it.
demo_writing_xml_into_file $xml_file_name

if file_exists $xml_file_name; then
   echo "$xml_file_name exists"
else
   echo "$xml_file_name does not exist"
fi

working_dir_demo
substring_removal_demo

