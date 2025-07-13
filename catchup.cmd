@echo off
setlocal EnableDelayedExpansion

SET "TEST_FOLDER=D:\wabbajack\modlistinstalls\SME\mods\- Dev Files"
REM SET "TEST_FOLDER=D:\wabbajack\modlistinstalls\NEFARAM.15.4.1\mods\AaDevelopment"

SET "SRC_DIR=%~dp0src"
SET "TEST_SCRIPT_SRC_DIR=.\extern\add-ons\sltr_test_scripts"
set "TARGET_TEST_SCRIPTS_DIR=%TEST_FOLDER%"

echo Copy test .sltscript from "%TEST_SCRIPT_SRC_DIR%" to "%TARGET_TEST_SCRIPTS_DIR%"
xcopy /s /i /y "%TEST_SCRIPT_SRC_DIR%\*.*" "%TARGET_TEST_SCRIPTS_DIR%\"

SET "DLL_SRC=.\plugin\sl-triggers\build\release-msvc\sl-triggers.dll"
SET "SRC_DLL_DIR=%SRC_DIR%\SKSE\Plugins\"

echo Copy sl-triggers.dll to %SRC_DIR%
xcopy /y "%DLL_SRC%" "%SRC_DLL_DIR%"

echo Copying from "%SRC_DIR%\" to "%TEST_FOLDER%\"
xcopy /e /i /y /exclude:catchup_exclusion.txt "%SRC_DIR%\" "%TEST_FOLDER%\"

echo Done populating "%TEST_FOLDER%"

endlocal
