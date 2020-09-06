cd %~dp0
allegro -s CustomShapes.scr
pad_designer -s 2019-11-20_18-26-53_pads.scr
CALL :checkfile "RX17p72Y45p53D0T.pad"
CALL :checkfile "RX21p72Y69p53D0T.pad"
CALL :checkfile "RX19p72Y57p53D0T.pad"
allegro -s 2019-11-20_18-26-53_brd.scr
CALL :checkfile "32A.psm"
CALL :checkfile "32A-M.psm"
CALL :checkfile "32A-L.psm"

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
