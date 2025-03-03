#!/bin/bash

# Function to display help
usage() {
    echo "Usage: $0 [-h] [-d directory] [-f filename]"
    echo "  -h            Display this help message"
    echo "  -d directory  Specify the directory name (default: test_directory)"
    echo "  -f filename   Specify the file name (default: test_file.txt)"
    exit 1
}

# Default values
dir_name="test_directory"
file_name="test_file.txt"

# Parse options
while getopts ":hd:f:" opt; do
    case ${opt} in
        h )
            usage
            ;;
        d )
            dir_name=$OPTARG
            ;;
        f )
            file_name=$OPTARG
            ;;
        \? )
            echo "Invalid option: -$OPTARG" >&2
            usage
            ;;
    esac
done

# Ensure directory and filename are valid using a regex
if [[ ! "$dir_name" =~ ^[a-zA-Z0-9_-]+$ || ! "$file_name" =~ ^[a-zA-Z0-9_.-]+$ ]]; then
    echo "Error: Directory or file name contains invalid characters. Use only letters, numbers, underscores, and dashes."
    exit 1
fi

# Define full file path
file_path="$dir_name/$file_name"

# Create directory
mkdir -p "$dir_name"
echo "Directory '$dir_name' created."

# Create a file and write some text
echo "This is a test file." > "$file_path"
echo "File '$file_path' created and text written."

# Display the file contents
echo "Contents of '$file_path':"
cat "$file_path"

# Ask user if they want to delete the file and directory
read -p "Do you want to delete the directory and file? (y/n): " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
    rm -r "$dir_name"
    echo "Directory and file deleted."
else
    echo "Directory and file kept."
fi
