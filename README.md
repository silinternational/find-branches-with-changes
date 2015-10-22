# Find Branches with Changes

Shell script to find the Git branches that contain changes to a particular file 
which have not yet been merged back into a specific branch. Helper scripts are 
included for using this from a [SourceTree](https://www.sourcetreeapp.com/) 
custom action.

## SourceTree custom action

### Setup (on Windows)

To use this as a custom action in SourceTree on a Windows PC, do the following:

1. Clone/copy this repo to somewhere on your computer.
2. Open SourceTree.
3. Click ```Tools``` > ```Options```.
4. Select the "Custom Actions" tab at the top of the dialog that opened.
5. Click "Add".
6. In the "Menu caption" field, put something like "Find changes not yet merged
   to local develop".
7. Turn on the "Show Full Output" option.
8. Click the ```...``` browse button beside the "Script to run" field, select
   the ```find-branches_sourcetree-custom-action.bat``` file wherever you saved
   it to on your computer, and click "Open".
9. In the "Parameters" field, put the following:  
   ```develop refs/ $REPO $FILE```  
   (For more information about these parameters, see below).
10. Click "OK".
11. Click "OK" to close the "Options" dialog.
12. Close SourceTree (to finish updating the list of Custom Actions shown for
   right-click actions).

### Basic Usage (on Windows)

To view the list of branches with contain commits where a specific file is 
changed (and which have not yet been merged back into develop)... 

1. Open SourceTree.
2. When viewing the history of a repo, select the ```File Status``` tab near the
   bottom-middle of the SourceTree window.
3. In the search field near the top-right corner, type part or all of the name
   of the file whose unmerged changes you want to see.
4. Right-click on the file, select ```Custom Actions``` > ```Find unmerged
   changes to file```.

After some text from Git, it should show the names of any branches where that
file has changed.

For example:

    find-branches_sourcetree-custom-action.bat C:\Projects\find-branches-with-changes README.md
    Welcome to Git (version 1.9.5-preview20141217)


    Run 'git help git' to display the help index.
    Run 'git help <command>' to display help for specific commands.





    Branches where "README.md" has been changed (if any):

    -----

    feature/initial-working-version

    -----
    Done.


    Completed successfully.


## Parameters for SourceTree Custom Action

The parameters provided to the SourceTree custom action dialog follow this 
pattern:

1. The branch that the changes have NOT yet been merged back into.
2. The pattern to use for getting the list of branches. This value is passed to 
   the ```git for-each-ref``` command.
   * To only list remote branches, use ```refs/remotes/origin/```.
   * To list all branches, use ```refs/```.
3. The string ```$REPO```, which SourceTree will replace with the root folder 
   of the repository.
4. The string ```$FILE```, which SourceTree will replace with the list of 
   selected files (ideally only one).

## Notes

* When you are done searching for a file, make sure you did not leave anything 
  typed into the search field. Otherwise, you may waste some time being 
  confused why you do not see the expected files in the staged/unstaged areas 
  when doing a commit.
* Selecting multiple files at a time will currently only return results for 
  whichever file SourceTree passed to the script first, so it is best to do 
  this one-at-a-time at the moment.
