@echo off

REM Change to this script's folder.
cd %~dp0

REM Run the shell script, passing it the arguments we received.
"c:\Program Files (x86)\Git\bin\sh.exe" --login -i -c "find-branches_sourcetree-custom-action.sh \"%~1\" \"%~2\" \"%~3\" \"%~4\""
