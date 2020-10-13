# Function which writes XML text into a given file.
# Arguments:
#       $1: file
function demo_writing_xml_into_file() {
    # $0 is the name of the calling file e.g. ./demo.sh
    echo echo "demo_writing_xml_into_file(): \$0 is $0"
    echo echo "demo_writing_xml_into_file(): \$1 is $1"
    file_name=$1

    if [ -v DISABLE_XML_TO_FILE ]; then
        # DISABLE_XML_TO_FILE can take any value, even "false"
        echo "DISABLE_XML_TO_FILE is defined"
        return 0
    fi

    if [  ! $file_name ]; then
        echo "file_name is not defined"
        return 0
    fi

    (
        echo '<Project ToolsVersion="1.0" xmlns="http://schemas.example.com/developer/2020">'
        echo '     <PropertyGroup>'
        echo '       <Mitigation>false</Mitigation>'
        echo '       <ImportDirectoryBuildProps>false</ImportDirectoryBuildProps>'
        echo '     </PropertyGroup>'
        echo '</Project>'
    ) > $file_name
}

# Function which checks if give file exists.
# Arguments:
#       $1: file
function file_exists() {
    [ -f $1 ]
}