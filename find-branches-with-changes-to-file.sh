#!/bin/sh

# PURPOSE: Find (and list) the branches that contain changes to a particular
#          file which have not yet been merged back into a specific branch.

# Get the arguments passed to this script.
while getopts ":d:p:n:f:" opt; do
    case $opt in
        d) repo_directory="$OPTARG"
        ;;
        p) for_each_ref_pattern="$OPTARG"
        ;;
        n) not_yet_merged_into="$OPTARG"
        ;;
        f) file_in_question="$OPTARG"
        ;;
        \?) echo "Invalid option -$OPTARG" >&2
        ;;
    esac
done

# Make sure all the arguments were provided.
if [ "$repo_directory" == "" ]; then
    echo "You must specify the directory of the Git repo (using the -d argument)";
    echo "EXAMPLE: -d \".\"";
    exit 1;
fi;
if [ "$for_each_ref_pattern" == "" ]; then
    echo "You must specify the for-each-ref pattern (using the -p argument)";
    echo "EXAMPLE: -p \"refs/remotes/origin/\"";
    exit 1;
fi;
if [ "$not_yet_merged_into" == "" ]; then
    echo "You must specify the not-yet-merged-into branch name (using the -n argument)";
    echo "EXAMPLE: -n \"develop\"";
    exit 1;
fi;
if [ "$file_in_question" == "" ]; then
    echo "You must specify the file in question (using the -f argument)";
    echo "EXAMPLE: -f \"application/composer.json\"";
    exit 1;
fi;

# Output a visual separator.
echo -----

## TEMP: Show the given arguments.
# printf "Argument repo_directory is %s\n" "$repo_directory"
# printf "Argument for_each_ref_pattern is %s\n" "$for_each_ref_pattern"
# printf "Argument not_yet_merged_into is %s\n" "$not_yet_merged_into"
# printf "Argument file_in_question is %s\n" "$file_in_question"
# exit

# Change to the repo's directory.
cd $repo_directory

# Get the list of branches we should examine.
RELEVANT_BRANCHES="$(git for-each-ref --format="%(refname:short)" $for_each_ref_pattern | grep -v "^master$" | grep -v "^origin/master$" | grep -v "develop$" | grep -v "origin/develop$" | grep -v "^origin/HEAD$")"

# For each of the relevant branches that we'll examine...
while read -r br; do

    # TEMP
    #echo "$br";
    
    # See if any commits have not yet been merged back into the named branch.
    git cherry $not_yet_merged_into $br | while read x h; do
    
        if [ "`git log -n 1 --format=%H $h -- $file_in_question`" = "$h" ]; then 
            echo "$br"
        fi;
    done;
    
done <<< "$RELEVANT_BRANCHES" | sort -u # Sort the results, removing duplicates.

echo '-----'
echo 'Done.'
