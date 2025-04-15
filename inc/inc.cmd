@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

REM SET SKSE_SRC_ROOT=D:\src\sksemods
REM SET NEF_SRC_ROOT=%SKSE_SRC_ROOT%\Nefaram

SET BETH=%INC_ROOT%\beth
SET PAPUTIL=%INC_ROOT%\paputil
SET PO3=%INC_ROOT%\po3
REM SET SKI=D:\SkyrimFiles\papyrus\PAPYRUS\SRC_SKYUI
REM Replaced with...
SET SKI=%INC_ROOT%\skyui
SET MFG=%INC_ROOT%\mfg
SET SXL=%INC_ROOT%\sexlab
REM SET DD52=%INC_ROOT%\dd52
REM SET DDI41=%INC_ROOT%\ddi-4.1
SET SLSO=%INC_ROOT%\slso
REM SET SLSMOOTHFEXP=%INC_ROOT%\slsmoothfexp
REM SET SLCUM=%INC_ROOT%\slcumoverlays
REM SET FHU=%INC_ROOT%\fhu
REM SET RACEMENU=%INC_ROOT%\racemenu
REM SET SLIF=%INC_ROOT%\slif
SET CONUTIL=%INC_ROOT%\conutil
REM SET NEFPATCH=%INC_ROOT%\nefpatch
REM SET SLANIMRM=%INC_ROOT%\slanimrm
REM SET FNIS=%INC_ROOT%\fnis
REM SET ZAZ=%INC_ROOT%\zaz
REM SET APROPOS2=%INC_ROOT%\apropos2
REM SET XPMSE=%INC_ROOT%\xpmse
REM SET SPLSIPH=%INC_ROOT%\spellsiphon
REM SET SPLFRG=%INC_ROOT%\spellforge

REM Replacing SLA with AROUSED
REM SET SLA=D:\SkyrimFiles\papyrus\PAPYRUS\SRC_SLA
REM Uncomment the following for SexLab Aroused NG, and comment out OSLAroused
REM SET AROUSED=%INC_ROOT%\sexlabarousedng
REM Uncomment the following for OSLAroused, and comment out SexLab Aroused NG
REM SET AROUSED=%INC_ROOT%\oslaroused

:: The calling script may pass a variable name to exclude
SET EXCLUDE_VAR=%1

:: Initialize the INC_PATH variable
SET INC_PATH=

REM order is important; first found is first used, so if SKSE does not precede BETH you will not see your SKSE functions, you have been warned

:: Loop through known variables
REM FOR %%V IN (SKSE BETH PAPUTIL PO3 SKI MFG SXL DD52 AROUSED SLSO SLSMOOTHFEXP SLCUM FHU RACEMENU SLIF CONUTIL NEFPATCH SLANIMRM FNIS ZAZ APROPOS2 XPMSE SPLSIPH SPLFRG) DO (
FOR %%V IN (SKSE BETH PAPUTIL PO3 SKI MFG SXL SLSO CONUTIL) DO (
    IF NOT "%%V"=="%EXCLUDE_VAR%" (
        IF DEFINED INC_PATH (
            SET INC_PATH=!INC_PATH!;!%%V!
        ) ELSE (
            SET INC_PATH=!%%V!
        )
    )
)

:: Export INC_PATH to the parent script
ENDLOCAL& SET INC_PATH=%INC_PATH%
