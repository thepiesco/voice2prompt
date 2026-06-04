# voice2prompt

Deutsche Spracheingabe für Claude Code (und alles andere mit Texteingabe).
Drück eine Taste, sprich los, drück wieder — dein Text landet als sauber
formulierter Prompt genau dort, wo dein Cursor gerade steht.

Läuft komplett lokal (Whisper auf CPU) und kostet pro Polish-Aufruf ~0.001 €
über die Anthropic-API (Claude Haiku).

## Was es kann

Vier Modi, exklusiv schaltbar per Hotkey:

| Hotkey | Modus | Was es macht |
|---|---|---|
| **Strg+Leertaste** | Aufnahme an / aus | Whisper transkribiert deutsche Sprache lokal |
| **Strg+Alt+P** | **Coding** | Brain-Dump → klarer Imperativ-Prompt für Claude Code |
| **Strg+Alt+I** | **Casual** | Erkennt Mail vs WhatsApp → fertige Nachricht mit Anrede + Schluss bzw. lockerem Ton |
| **Strg+Alt+O** | **Freundin** | Warme, liebevolle WhatsApp-Nachricht — wertet trockene Aussagen romantisch auf |

Drückst du denselben Modus zweimal → Polish aus, nur roher Whisper-Text.
Drückst du einen anderen Modus → wechselt. Overlay oben am Bildschirm zeigt
den aktuellen Modus farbig an (grün/blau/pink).

## Installation (für Freunde mit Claude Code)

```bash
# 1. Repo holen
git clone https://github.com/thepiesco/voice2prompt.git
cd voice2prompt

# 2. Python-Deps
py -m pip install -r requirements.txt

# 3. API-Key eintragen (für Polish — optional, ohne läuft nur Whisper-Roh-Text)
#    Key holen: https://console.anthropic.com/settings/keys
copy api.key.example api.key
notepad api.key
#    Inhalt durch deinen echten sk-ant-... Key ersetzen, speichern, schließen

# 4. Starten
start.cmd
```

Beim ersten Start lädt Whisper das deutsche Modell (~480 MB, einmalig).

Optional: **Autostart bei Windows-Login** — Verknüpfung in den Startup-Ordner:
```powershell
$s = (New-Object -ComObject WScript.Shell).CreateShortcut(
    "$([Environment]::GetFolderPath('Startup'))\voice2prompt.lnk")
$s.TargetPath = (Get-Command pythonw).Source
$s.Arguments = '"voice2prompt.py"'
$s.WorkingDirectory = (Get-Location).Path
$s.WindowStyle = 7
$s.Save()
```

## Tipps

- **Cursor erst ins Zielfenster setzen, dann Strg+Leertaste.** Das Tool
  paste'd via Strg+V ins aktive Fenster — wenn dein Cursor woanders ist,
  landet der Text woanders.
- **Beenden:** Rechtsklick aufs Mikro-Icon in der Taskleiste → Beenden,
  oder `stop.cmd`.
- **Debug:** `debug.cmd` startet mit sichtbarer Konsole. Log liegt in
  `voice2prompt.log`.
- **Mikrofon ändern:** `py _check.py` listet alle Input-Devices.

## Modi-Anpassung

Die System-Prompts der Polish-Modi stehen in `voice2prompt.py` als
`POLISH_CODING`, `POLISH_CASUAL`, `POLISH_ROMANCE`. Komplett anpassbar — dein
eigener Stil, deine eigenen Few-Shot-Beispiele.

## Stack

- [faster-whisper](https://github.com/SYSTRAN/faster-whisper) (small, int8, CPU)
- [Anthropic SDK](https://github.com/anthropics/anthropic-sdk-python) (Claude Haiku 4.5)
- Tkinter Overlay, pystray Tray-Icon, Windows `RegisterHotKey` für stabile globale Hotkeys
