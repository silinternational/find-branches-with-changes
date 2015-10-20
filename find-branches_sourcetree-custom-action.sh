#!/bin/sh

printf "Branches where \"%s\" has been changed (if any):\n" "$4"
find-branches-with-changes-to-file.sh -d "$3" -p "$2" -n "$1" -f "$4"
