# AIbersetzer

> Sprache-zu-Text mit Stil. Drück eine Taste, sprich los, drück wieder — und je
> nachdem welchen Modus du gewählt hast, landet dein Text als Coding-Prompt, als
> liebevolle WhatsApp, als bayrische Begrüßung oder als Yoda-Weisheit im aktiven
> Eingabefeld.

Läuft komplett lokal (Whisper auf CPU). Der Polish-Schritt geht über die
Anthropic-API (Claude Haiku, ~0.001 € pro Aufnahme).

## Bedienung

**Ein Hotkey: `Strg + Leertaste` = Aufnahme an/aus.**

Modus wählst du im **Drop-Down** oben im Overlay-Fenster per Mausklick.

## Modi

| Modus | Was er macht |
|---|---|
| **Aus** | Rohtext aus Whisper, kein Polish |
| **Coding** | Claude-Code-Prompt — Frage bleibt Frage, Aussage bleibt Aussage, Auftrag wird Imperativ |
| **Casual** | Mail (mit Anrede + „Viele Grüße, Piero") ODER WhatsApp, auto-erkannt |
| **Bayrisch** | Servus! Bayrische Färbung — dosiert, kein Lederhosen-Klischee |
| **Pfälzisch** | Rhoihesse — „Ei Mike, des is um 5, gell" |
| **Freundin Light** | Liebevoll-dezent. Sagt häufig „Liebes" — sparsame Emojis |
| **Freundin Hardcore** | Volle Romance — Herzchen, Verstärker, „mit dir", „wir beide" |
| **Yoda** | „Loeschen die Dateien, du musst. Hmm." |
| **Goethe** | „Wann gedenkst du in trauter Häuslichkeit heim zu finden?" |
| **Marketing-BS** | „Holistische Synergien für maximales User-Engagement-ROI" |
| **Pirat** | „Yarr Matrose! Beim Klabauterbart!" |

## Installation (für Freunde mit Claude Code)

```bash
# 1. Klonen
git clone https://github.com/thepiesco/voice2prompt.git
cd voice2prompt

# 2. Python-Deps
py -m pip install -r requirements.txt

# 3. API-Key (für Polish — ohne läuft nur Whisper-Roh-Text)
copy api.key.example api.key
notepad api.key      # sk-ant-... Key reinpasten, speichern
# Key holen: https://console.anthropic.com/settings/keys

# 4. Starten
start.cmd
```

Beim ersten Start lädt Whisper das deutsche Modell (~480 MB, einmalig).

### Autostart bei Windows-Login

```powershell
$s = (New-Object -ComObject WScript.Shell).CreateShortcut(
    "$([Environment]::GetFolderPath('Startup'))\AIbersetzer.lnk")
$s.TargetPath = (Get-Command pythonw).Source
$s.Arguments = '"voice2prompt.py"'
$s.WorkingDirectory = (Get-Location).Path
$s.WindowStyle = 7
$s.Save()
```

## Eine Zeile in Claude Code

```
Klone github.com/thepiesco/voice2prompt nach C:\Tools\AIbersetzer,
installiere requirements.txt, kopiere api.key.example zu api.key (Inhalt mit
meinem eigenen Anthropic-Key ersetzen — Key holen unter
console.anthropic.com/settings/keys), dann start.cmd starten.
```

## Tipps

- **Cursor erst ins Zielfenster, dann Strg+Leertaste.** Tool paste'd via Strg+V
  ins aktive Fenster.
- **Beenden:** Rechtsklick aufs Mikro-Tray-Icon → Beenden, oder `stop.cmd`.
- **Debug:** `debug.cmd` startet mit sichtbarer Konsole. Log: `voice2prompt.log`.
- **Modi-Anpassung:** System-Prompts liegen in `voice2prompt.py` als
  `POLISH_CODING`, `POLISH_CASUAL`, `POLISH_BAYRISCH` usw. — komplett editierbar.

## Stack

- [faster-whisper](https://github.com/SYSTRAN/faster-whisper) (small, int8, CPU)
- [Anthropic SDK](https://github.com/anthropics/anthropic-sdk-python) (Claude Haiku 4.5)
- Overlay rendert in Edge WebView2 via [pywebview](https://pywebview.flowrl.com/)
  — Command-Bar-Design mit Live-Waveform (Canvas), runde Ecken über
  transparentes Fenster + CSS (kein GDI-Region-Gefrickel mehr)
- Windows `RegisterHotKey` für stabilen globalen Aufnahme-Hotkey, abgesichert
  durch einen Single-Instance-Lock (Named Mutex)
- Gewählter Modus wird in `settings.json` gemerkt (überlebt Neustart)
- pystray Tray-Icon
