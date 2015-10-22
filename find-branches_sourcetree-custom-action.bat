@echo off

REM Change to this script's folder.
cd %~dp0

REM Run the shell script, passing it the arguments we received.
"%LOCALAPPDATA%\Atlassian\SourceTree\git_local\bin\sh.exe" --login -i -c "find-branches_sourcetree-custom-action.sh \"%~1\" \"%~2\" \"%~3\" \"%~4\""
