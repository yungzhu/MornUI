@echo off
del /F /Q morn.reg
cls
SET mornmaindir=%CD%
SET mornmaindir=%mornmaindir:\=\\%
> ".\morn.reg" ECHO Windows Registry Editor Version 5.00
>>".\morn.reg" ECHO. 
>>".\morn.reg" ECHO [HKEY_CLASSES_ROOT\.morn]
>>".\morn.reg" ECHO @="morn_auto_file"
>>".\morn.reg" ECHO.
>>".\morn.reg" ECHO [HKEY_CLASSES_ROOT\morn_auto_file\shell\open\command]
>>".\morn.reg" ECHO @="\"%mornmaindir%\\Main.exe\" \"%%1\""
morn.reg
del /F /Q morn.reg