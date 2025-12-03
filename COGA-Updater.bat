@echo off
title COGA-Updater
echo ===========================================
echo          COGA INVENTORI UPDATER
echo ===========================================
echo.

REM --- 1. Path direktori aplikasi ---
set APPDIR=%~dp0

echo Direktori Aplikasi :
echo %APPDIR%
echo.

REM --- 2. Cek file update ---
if not exist "%APPDIR%Update-COGA.zip" (
    echo ERROR : File Update-COGA.zip tidak ditemukan!
    pause
    exit
)

echo Mengekstrak update...

REM --- 3. Extract ZIP (tanpa software tambahan) ---
powershell -command "Expand-Archive -Force '%APPDIR%Update-COGA.zip' '%APPDIR%'"

echo Extract selesai!
echo.

REM --- 4. Jalankan kembali aplikasi ---
echo Menjalankan ulang aplikasi...
start "" "%APPDIR%COGA-Inventori.exe"

echo.
echo Update selesai!
echo Membersihkan file updater...
echo.

REM --- 5. Buat script penghapus diri ---
(
  echo @echo off
  echo ping 127.0.0.1 -n 2 ^>nul
  echo del "%APPDIR%COGA-Updater.bat"
  echo del "%APPDIR%COGA-Updater.ps1"
  echo del "%APPDIR%delete_me.bat"
) > "%APPDIR%delete_me.bat"

start "" "%APPDIR%delete_me.bat"
exit
