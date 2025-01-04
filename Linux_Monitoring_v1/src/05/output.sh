#!/bin/bash

cat <<EOF
Total number of folders (including all nested ones) = $folder_count
TOP 5 folders of maximum size arranged in descending order (without inner folders):
$folder_sizes
Total number of files = $file_count
Number of:
Configuration files (with the .conf extension) = $conf_count
Text files (with shell scripts) = $text_count_with_sh
Text files (without shell scripts) = $text_count_no_sh
Executable files = $exec_count
Log files (with the extension .log) = $log_count
Archive files = $archive_count
Symbolic links = $link_count
TOP 10 files of maximum size arranged in descending order (path, size and type):
$top_files
TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):
$exec_files
Script execution time (in seconds) = $execution_time
EOF
