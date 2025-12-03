$APPDIR = Split-Path -Parent $MyInvocation.MyCommand.Definition

Write-Host "======================================="
Write-Host "        COGA INVENTORI UPDATER"
Write-Host "======================================="

$zipPath = Join-Path $APPDIR "Update-COGA.zip"

if (!(Test-Path $zipPath)) {
    Write-Host "ERROR: Update-COGA.zip tidak ditemukan!"
    Read-Host "Tekan Enter untuk keluar"
    exit
}

Write-Host "Mengekstrak update..."
Expand-Archive -LiteralPath $zipPath -DestinationPath $APPDIR -Force
Write-Host "Extract selesai!"

Start-Process "$APPDIR\COGA-Inventori.exe"

Write-Host "Menghapus file updater..."

# === SELF DELETE TANPA ERROR ===
$delete = @"
Start-Sleep -Seconds 2
Remove-Item "$APPDIR\COGA-Updater.bat" -Force -ErrorAction SilentlyContinue
Remove-Item "$APPDIR\COGA-Updater.ps1" -Force -ErrorAction SilentlyContinue
Remove-Item "$APPDIR\delete_me.ps1" -Force -ErrorAction SilentlyContinue
"@

$delFile = Join-Path $APPDIR "delete_me.ps1"
Set-Content $delFile $delete

Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File `"$delFile`""
exit
