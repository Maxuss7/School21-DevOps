#!/bin/bash

if [ -z "$1"  ]; then
	echo "No parameter."
	exit 1	
fi

REGEX="^[0-9]+$"

if [[ "$1" =~ $REGEX ]]; then
	echo "Parameter is a number. Please, enter text."
	exit 1
fi

echo "Your parameter is: $1"
