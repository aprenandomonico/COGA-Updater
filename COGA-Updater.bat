@echo off
title COGA-Updater
setlocal enabledelayedexpansion

echo ===========================================
echo          COGA INVENTORI UPDATER
echo ===========================================
echo.

set "APPDIR=%~dp0"

echo Direktori Aplikasi :
echo %APPDIR%
echo.

if not exist "%APPDIR%Update-COGA.zip" (
    echo ERROR : File Update-COGA.zip Tidak Ditemukan !!!
    pause
    exit
)

echo Mengekstrak Update ...
powershell -command "Expand-Archive -Force '%APPDIR%Update-COGA.zip' '%APPDIR%'"

echo Extract Selesai !!!
echo.

echo Menjalankan Ulang Aplikasi ...
start "" "%APPDIR%COGA-Inventori.exe"

echo.
echo Update Selesai !!!
echo Membersihkan File Updater ...
echo.

rem === SCRIPT SELF DELETE TANPA ERROR ===
(
  echo @echo off
  echo timeout /t 2 >nul
  echo del "%APPDIR%COGA-Updater.bat" ^>nul 2^>^&1
  echo del "%APPDIR%COGA-Updater.ps1" ^>nul 2^>^&1
  echo del "%%~f0" ^>nul 2^>^&1
) > "%APPDIR%delete_me.bat"

start "" cmd /c "%APPDIR%delete_me.bat"
exit
