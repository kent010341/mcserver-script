@echo off

:: ===================================================
:: <<Edit Here>>
:: memory used for server, unit: GB
set memory=2

:: filename of server.jar
set filename=server.jar

:: show GUI? (true/false)
set show_gui=true

:: ===================================================
:: start server
set /a mb=%memory%*1024
echo Use memory: %memory% GB (%mb% MB)

IF %show_gui%==true (
    java -Xmx%mb%M -Xms%mb%M -jar %filename%
) ELSE IF %show_gui%==false (
    java -Xmx%mb%M -Xms%mb%M -jar %filename% nogui
) ELSE (
    echo Invalid value.
)
