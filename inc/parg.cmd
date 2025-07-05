@echo off
setlocal enabledelayedexpansion

set "tool=C:\tools\HeadlinerForPapyrus\PapyrusSourceHeadliner.exe"


set "target_folder=."

for %%F in ("%target_folder%\*") do (
    if exist "%%F" (
        for %%A in ("%%F") do (
            if %%~zA gtr 2048 (
                rem Get filename without extension
                set "filename=%%~nA"
                
                rem Check if filename is not empty
                if not "!filename!"=="" (
                    echo Running %tool% on %%A (filename: !filename!)
                    "%tool%" !filename!
                ) else (
                    echo Skipping empty filename: %%A
                )
            )
        )
    )
)

endlocal
