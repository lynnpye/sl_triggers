@echo off
setlocal

:: Check for exactly one argument
if "%~1"=="" (
    echo Usage: %~nx0 ^<integer-version-number^>
    exit /b 1
)

:: Assign the argument
set "INPUT=%~1"

:: Check if INPUT is numeric using string parsing
set "VERNO="
for /f "delims=0123456789" %%A in ("%INPUT%") do (
    echo Error: Argument must be a valid integer.
    exit /b 1
)
set "VERNO=%INPUT%"

:: Confirm assignment
echo VERNO is set to %VERNO%


set "THEZIP=%~dp0\sl_triggers%VERNO%.zip"

del /f %THEZIP%

pushd src
7z a -tzip -r "%THEZIP%" sl_triggers
popd

endlocal
