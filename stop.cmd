@echo off
REM Beendet alle laufenden voice2prompt-Instanzen
wmic process where "CommandLine like '%%voice2prompt.py%%'" call terminate >nul 2>&1
echo voice2prompt beendet.
