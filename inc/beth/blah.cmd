@echo off
setlocal

:: Set the TOOL variable to the path or name of your tool
set "TOOL=C:\tools\HeadlinerForPapyrus\PapyrusSourceHeadliner.exe"

:: Loop through all .psc files in the current directory
for %%F in (*.psc) do (
    :: Get full path, file size, and filename without extension
    for %%A in ("%%F") do (
        set "FullPath=%%~fA"
        set "FileSize=%%~zA"
        set "NoExt=%%~dpnA"
    )

    setlocal enabledelayedexpansion
    if 1 == 1 (
        echo Running %TOOL% on !NoExt!
        "%TOOL%" "!NoExt!"
    )
    endlocal
)

endlocal
