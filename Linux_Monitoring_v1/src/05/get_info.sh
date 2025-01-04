#!/bin/bash

silent_run() {
  "$@" 2>/dev/null
}

start_time=$(date +%s.%N)

# Total number of folders (inner ones are included)
folder_count=$(silent_run find "$directory" -type d | wc -l)

# Top 5 folders by size
folder_sizes=$(silent_run du -sh "$directory"* | sort -rh | head -n 5 | awk '{printf "%d - %s %s\n", NR, $2, $1}')

# Total number of files
file_count=$(silent_run find "$directory" -type f | wc -l)

# Number of different file types
conf_count=$(silent_run find "$directory" -type f -name "*.conf" | wc -l)
# Without shell scripts
text_count_no_sh=$(silent_run find "$directory" -type f -exec file {} \; | grep "text" | grep -v "shell script" | wc -l)
# With shell script
text_count_with_sh=$(silent_run find "$directory" -type f -exec file {} \; | grep "text" | wc -l)

exec_count=$(silent_run find "$directory" -type f -executable | wc -l)
log_count=$(silent_run find "$directory" -type f -name "*.log" | wc -l)
archive_count=$(silent_run find "$directory" -type f \( -name "*.tar" -o -name "*.gz" -o -name "*.zip" -o -name "*.rar" -o -name "*.tar.gz" \) | wc -l)
link_count=$(silent_run find "$directory" -type l | wc -l)

# Top 10 files by size (path, size, type)
top_files=$(silent_run find "$directory" -type f -exec du -h {} + | sort -rh | head -n 10 | awk '{
    size=$1; path=$2;
    match(path, /\.([^.]+)$/, ext);
    type=(ext[1] != "" ? ext[1] : "none");
    printf "%d - %s, %s, %s\n", NR, path, size, type;
}')

# TOP 10 executable files of the maximum size 
exec_files=$(silent_run find "$directory" -type f -executable -exec du -h {} + | \
  sort -rh | head -n 10 | \
  while read -r size path; do
    hash=$(md5sum "$path" 2>/dev/null | awk '{print $1}')
    printf "%-80s %10s %32s\n" "$path" "$size" "$hash"
  done)


end_time=$(date +%s.%N)
execution_time=$(printf "%.6f" $(echo "$end_time - $start_time" | bc))