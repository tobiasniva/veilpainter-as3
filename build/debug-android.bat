@echo off
setlocal enabledelayedexpansion

REM ---- constants ----
set APP_ID=com.gimbalgames.veilpainter
set SWF=bin\VeilPainter.swf
set APK=bin\VeilPainter.apk
set APP_XML=VeilPainter-android.xml

set KEYSTORE=certs\debug_cert.p12
set STORETYPE=pkcs12

REM ---- check signing password ----
if "%AIR_STOREPASS%"=="" (
  echo ERROR: AIR_STOREPASS environment variable is not set
  exit /b 1
)

REM ---- package debug APK ----
adt -package ^
  -target apk-debug ^
  -storetype %STORETYPE% ^
  -keystore %KEYSTORE% ^
  -storepass %AIR_STOREPASS% ^
  %APK% ^
  %APP_XML% ^
  %SWF% ^
  -e assets\alphas alphas ^
  -e assets\icons  icons ^
  || exit /b 1

REM ---- install + run ----
adb shell am force-stop %APP_ID% >nul 2>&1
adb install -r %APK% || exit /b 1
adb shell monkey -p %APP_ID% -c android.intent.category.LAUNCHER 1 >nul

echo OK: Android debug APK installed and launched
endlocal
