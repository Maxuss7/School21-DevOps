#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 /path/to/directory/"
  exit 1
fi

directory="$1"
if [[ ! "$directory" =~ /$ ]]; then
  echo "Path must end with '/'"
  exit 1
fi

if [ ! -d "$directory" ]; then
  echo "The path $directory does not exist or is not a directory"
  exit 1
fi