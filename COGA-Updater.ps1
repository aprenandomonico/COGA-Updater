Write-Host "======================================="
Write-Host "        COGA INVENTORI UPDATER"
Write-Host "======================================="
Write-Host ""

$APPDIR = Split-Path -Parent $MyInvocation.MyCommand.Definition

Write-Host "Direktori Aplikasi:"
Write-Host $APPDIR
Write-Host ""

# --- 1. Cek ZIP ---
$zipPath = Join-Path $APPDIR "Update-COGA.zip"

if (!(Test-Path $zipPath)) {
    Write-Host "ERROR: Update-COGA.zip tidak ditemukan!"
    Read-Host "Tekan Enter untuk keluar"
    exit
}

Write-Host "Mengekstrak update..."

# --- 2. Extract ZIP ---
Expand-Archive -LiteralPath $zipPath -DestinationPath $APPDIR -Force

Write-Host "Extract selesai!"
Write-Host ""

# --- 3. Jalankan ulang app ---
Start-Process "$APPDIR\COGA-Inventori.exe"

Write-Host ""
Write-Host "Update selesai!"
Write-Host "Menghapus file updater..."
Write-Host ""

# --- 4. Self delete ---
$deleteScript = @"
Start-Sleep -Seconds 2
Remove-Item "$APPDIR\COGA-Updater.bat" -Force
Remove-Item "$APPDIR\COGA-Updater.ps1" -Force
Remove-Item "$APPDIR\delete_me.ps1" -Force
"@

$deleteFile = Join-Path $APPDIR "delete_me.ps1"
Set-Content -Path $deleteFile -Value $deleteScript

Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File `"$deleteFile`""
