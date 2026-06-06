# AIbersetzer – Changelog

In Laiensprache: was hat sich am Sprache-zu-Text-Übersetzer geändert und warum.

## 2026-06-06 – UI komplett neu: WebView statt Tkinter (echtes 2026er Design)

**Was war kaputt:**
CustomTkinter war auch mit Polish noch Windows-XP-Charme: klobiges Dropdown,
schwarze Ecken-Halos durch Color-Key-Antialias, keine echten Animationen,
keine Glassmorphism. Tkinter ist 1992er-Architektur, da hilft kein Lipstick.

**Was jetzt anders ist:**

- **Tkinter komplett raus.** Das UI rendert jetzt in **Edge WebView2** (in
  Windows 11 vorinstalliert) via `pywebview`. Das ist die gleiche Engine wie
  in Chrome — volles modernes CSS, GPU-beschleunigt.
- **Glassmorphism**: `backdrop-filter: blur(40px) saturate(180%)` mit
  semitransparentem Surface (rgba 0.82) — der Desktop scheint subtle durch.
- **Inter Variable Font** über Google Fonts (Fallback: Segoe UI Variable) —
  die de-facto Standard-Schrift moderner Web-Apps in 2025/26.
- **Custom Dropdown** mit Mode-Color-Dots pro Eintrag, smooth slide-down
  Animation, glassmorphem Hintergrund, sauberen Hover-States, Active-Indicator.
- **KBD-Style Tasten** für Hotkey-Hinweise (Strg + Leer) — wie moderne SaaS-Apps.
- **CSS-Animationen**: Status-Dot pulsiert bei rec/tx mit ring-ripple,
  Accent-Stripe links pulsiert subtil, smooth color-transitions bei Mode-Wechsel.
- **App-Name mit Akzent-Hervorhebung**: "AI" leuchtet in Mode-Farbe, Rest
  bleibt weiß — sieht wie ein modernes Logo aus.
- **Drag-to-move** via CSS (`-webkit-app-region: drag`), Dropdown bleibt
  klickbar.
- **Python↔JS Bridge**: Mode-Wechsel von JS → Python via `pywebview.api`,
  State-Updates von Python → JS via `evaluate_js`. Alle anderen Sachen
  (Audio, Whisper, Hotkey, Tray, Polish) bleiben unverändert.

**Entfallene Dependencies:** `tkinter`, `customtkinter`, `pywinstyles` —
neu hinzu: `pywebview` (~5MB, einmalig).

## 2026-06-06 – UI-Redesign (modern, abgerundet, transparent)

**Was war kaputt:**
Das Overlay sah oldschool aus: schwarze Ecken um den runden Rahmen,
klassisches Segoe UI 17 bold, klobiger 2px-Border, Trennlinie unterm Header.
Wirkte wie ein Tool aus 2015.

**Was jetzt anders ist:**

- **Schwarze Ecken weg.** Das Fenster nutzt jetzt den Windows-Color-Key-Trick
  (`-transparentcolor` auf einen exotischen Farbton): alle Pixel außerhalb der
  abgerundeten Form sind echt transparent — man sieht den Desktop dahinter
  durch die runden Ecken.
- **Größerer Radius**: `corner_radius=28` (vorher 20) — deutlich „weicher".
- **Border raus, Akzent-Streifen rein.** Statt klobigem 2px-Rahmen jetzt ein
  schlanker 3px-Akzentstreifen oben in der jeweiligen Modus-Farbe. Pulsiert
  bei Aufnahme/Transkribieren.
- **Moderne Typografie**: auto-detect für Segoe UI Variable Display
  (Windows-11-native, deutlich modernerer Look), Fallback auf Inter / Segoe UI.
  Größen + Weights angepasst (19/600 für App-Name, 15/600 für Status).
- **Pill-Dropdown**: höher (38px), runder (radius 19), tighter Font.
  Akzentfarbe wandert mit dem gewählten Modus.
- **Trennlinie unter Header weg** — moderne Apps gruppieren mit Whitespace
  statt Linien.
- **Generöseres Padding** (26px statt 20), Fenster auf 600×172 (vorher 560×138)
  für mehr Atemraum.
- **Zentrale Design-Tokens** (`COL_BG_SURFACE`, `COL_FG_PRIMARY` etc.) — eine
  Palette statt Hex-Streuung im Code.

## 2026-06-06 – Weniger Weigerungen, bessere Personas

**Was war kaputt:**
Manchmal kam keine Übersetzung sondern eine Claude-Fehlermeldung ("Tut mir leid,
das kann ich nicht…") als Text rausgepastet. Außerdem klang Besoffen wie ein
Comic-Trunkenbold ("hicks, hicks"), Justus wie ein schwärmerischer Liebhaber
("darling, babe"), und Freundin-Modus war zu nüchtern — fast nie Herzen im Alltag.

**Was jetzt anders ist:**

- **Keine Fehlermeldungen mehr als Ergebnis.** Ein Refusal-Detektor erkennt jetzt,
  wenn Claude trotz Anti-Refusal-Klausel verweigert ("Ich kann nicht…",
  "Sorry, I can't…", "Hier ist die Reformulierung:", "Könntest du mir mehr Kontext…").
  Bei Verdacht wird automatisch ein zweites Mal mit verschärftem Hinweis gefragt.
  Wenn auch das nicht klappt, kommt der **saubere Rohtext aus dem Whisper-Transkript**
  rein — nie wieder eine sichtbare KI-Weigerung im Clipboard.
- **Anti-Refusal-Klausel verschärft.** Klarer formuliert: Du bist Werkzeug, Filter,
  Diktaphon — keine Diskussion. Auch absurde, vulgäre, peinliche Inputs werden im
  Mode-Stil ausgeschrieben.
- **Freundin Light / Hardcore** dürfen jetzt auch im Alltag **ab und zu ein Herz**
  oder "Liebes" reinwerfen — nicht jede Nachricht, aber häufig genug, dass es warm
  bleibt. Default ist 1 Element pro Nachricht, ab und zu 2, selten 0 (vorher: meist 0,
  selten 1).
- **Besoffen ohne "hicks".** Kein echter Betrunkener tippt "hicks" auf WhatsApp.
  Stattdessen jetzt: echte Tippfehler (Daumen verrutscht), verschluckte Buchstaben,
  gedehnte Vokale, vertauschte Konsonanten, ineinander rutschende Wörter.
  Auch "haha"/"hehe" stark reduziert.
- **Justus jetzt kühl-abgehoben** statt darling/babe-warm. Old-Money-Snob mit müdem
  Augenroller ("frankly exhausting", "rather embarrassing", "beneath me") statt
  schwärmerischem Liebhaber. Keine Standardanrede "darling"/"babe" mehr.

**Dropdown-Labels angepasst:**
- "Besoffen – hicks, hicks…" → "Besoffen – lallig & vertippt"
- "Justus – Trust-Fund-Kid" → "Justus – abgehoben, Old Money"
