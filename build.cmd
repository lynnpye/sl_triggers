@echo off
setlocal EnableDelayedExpansion

SET "SKSE=D:\src\sksemods\skse64_2_00_20"
SET "PAPYRUS_EXE=C:\tools\Papyrus\PapyrusCompiler.exe"
REM

REM Everything below this line should be able to remain untouched
SET "INC_ROOT=%~dp0inc"
SET "SRC_DIR=%~dp0src"
SET "SRC_PEX_DIR=%SRC_DIR%\scripts"
REM

for %%F in ("%SRC_PEX_DIR%\*.pex") do (
    del "%%F"
	REM
)

REM

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

REM
REM
REM

endlocal
