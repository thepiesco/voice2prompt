@echo off
REM Mit sichtbarer Konsole starten — fuer Fehlersuche
title voice2prompt DEBUG
cd /d "%~dp0"
py voice2prompt.py
pause
