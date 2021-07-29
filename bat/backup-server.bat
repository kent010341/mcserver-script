@echo off

:: Check if backup folder is exist
IF NOT EXIST ./backup (
    mkdir backup
)

:: Set folder name with current time
set folder_name=world%date:~0,4%%date:~5,2%%date:~8,2%

:: Copy world folder
echo D|xcopy world worldcp
ren worldcp %folder_name%
move %folder_name% backup/

@pause
