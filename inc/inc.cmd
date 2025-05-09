@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

SET "SKSE=%INC_ROOT%\skse"
SET "BETH=%INC_ROOT%\beth"
SET "PAPUTIL=%INC_ROOT%\paputil"
SET "PO3=%INC_ROOT%\po3"
SET "SKI=%INC_ROOT%\skyui"
SET "MFG=%INC_ROOT%\mfg"
SET "DD52=%INC_ROOT%\dd52"
SET "SXL=%INC_ROOT%\sexlab"
SET "OSLA=%INC_ROOT%\osla"
SET "SLANG=%INC_ROOT%\slang"
SET "ADVFWK=%INC_ROOT%\advfwk"
SET "PYRAMID=%INC_ROOT%\pyramid"
SET "SLSO=%INC_ROOT%\slso"
SET "CONUTIL=%INC_ROOT%\conutil"
SET "DFR=%INC_ROOT%\dfr"

:: The calling script may pass a variable name to exclude
SET EXCLUDE_VAR=%1

:: Initialize the INC_PATH variable
SET INC_PATH=

REM order is important; first found is first used, so if SKSE does not precede BETH you will not see your SKSE functions, you have been warned

:: Loop through known variables
REM FOR %%V IN (SKSE BETH PAPUTIL PO3 SKI MFG SXL DD52 AROUSED SLSO SLSMOOTHFEXP SLCUM FHU RACEMENU SLIF CONUTIL NEFPATCH SLANIMRM FNIS ZAZ APROPOS2 XPMSE SPLSIPH SPLFRG) DO (
FOR %%V IN (SKSE BETH PAPUTIL PO3 SKI MFG DD52 SXL OSLA SLANG ADVFWK PYRAMID SLSO CONUTIL DFR) DO (
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
