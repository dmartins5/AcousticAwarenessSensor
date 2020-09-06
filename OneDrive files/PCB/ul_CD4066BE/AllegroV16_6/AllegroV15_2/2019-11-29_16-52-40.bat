cd %~dp0
allegro -s CustomShapes.scr
pad_designer -s 2019-11-29_16-52-40_pads.scr
CALL :checkfile "SX51Y51D31P.pad"
CALL :checkfile "EX51Y51D31P.pad"
CALL :checkfile "ths41x51x45x10.fsm"
allegro -s 2019-11-29_16-52-40_brd.scr
CALL :checkfile "N14.psm"

exit

:checkfile
@echo off
dir %1 1>nul 2>nul
if errorlevel 1 goto checkfile_err
goto end
:checkfile_err
echo Expected file %1 not found
pause > nul
exit
:end
@echo on
