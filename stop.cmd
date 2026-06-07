@echo off
REM Beendet alle laufenden AIbersetzer-Instanzen (WMIC ist veraltet -> PowerShell)
powershell -NoProfile -Command "Get-CimInstance Win32_Process -Filter \"name='pythonw.exe' OR name='python.exe'\" | Where-Object { $_.CommandLine -like '*voice2prompt.py*' } | ForEach-Object { Stop-Process -Id $_.ProcessId -Force }"
echo AIbersetzer beendet.
