#!/bin/sh

printf "Branches where \"%s\" has been changed (if any):\n" "$2"
find-branches-with-changes-to-file.sh -d "$1" -p "refs/remotes/origin/" -n "develop" -f "$2"
