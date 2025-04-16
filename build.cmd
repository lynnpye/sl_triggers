@echo off
setlocal EnableDelayedExpansion

SET "INC_ROOT=%~dp0inc"
SET "TARGET_DIR=%~dp0src\scripts"
SET "SKSE=D:\src\sksemods\skse64_2_00_20"
SET "PAPYRUS_EXE=C:\tools\Papyrus\PapyrusCompiler.exe"

DEL "%TARGET_DIR%\*.pex"

call .\inc\inc.cmd

set PSC_FILE=

if "%~1"=="" (
	set PSC_FILE=. -all
	goto filecheck
)

:beginloop
if "%~1"=="" goto endloop
set PSC_FILE=%1
shift
:filecheck
if "%PSC_FILE%"=="" goto endloop
pushd src\source\scripts
"%PAPYRUS_EXE%" %PSC_FILE% -o="%TARGET_DIR%" -i="%INC_PATH%" -f=TESV_Papyrus_Flags.flg -op 
popd
goto beginloop

:endloop

endlocal
