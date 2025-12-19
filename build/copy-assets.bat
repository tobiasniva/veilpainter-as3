@echo off
setlocal

REM Ensure bin exists
if not exist "bin" mkdir "bin"

xcopy /E /I /Y "assets\alphas" "bin\alphas" >nul
xcopy /E /I /Y "assets\icons"  "bin\icons"  >nul

echo OK: assets copied to bin\
endlocal