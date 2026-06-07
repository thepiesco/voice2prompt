# AIbersetzer – Changelog

In Laiensprache: was hat sich am Sprache-zu-Text-Übersetzer geändert und warum.

## 2026-06-07 – Fenster 25% kleiner

Auf Wunsch: das Overlay war einen Ticken zu groß. Jetzt ist alles um 25%
verkleinert – und zwar proportional (Schrift, Abstände, Waveform, Menü
skalieren per CSS-Maßstab `--sc` gemeinsam mit), also bleibt das Layout exakt
gleich, nur kompakter. Fenster 660→495 px breit, Position auf dem TV neu
zentriert. Runde Ecken/Schweben unverändert (auf echtem Bildschirm geprüft).

## 2026-06-07 – Nachbesserung: weißer Kasten weg + Opus-API-Schutz

**Was war kaputt:**
Nach dem Umbau schwebte das Overlay nicht, sondern erzeugte einen großen weißen
Kasten mit eckigen Ecken. Grund: ich hatte mich auf ein „durchsichtiges Fenster"
verlassen – das funktioniert auf diesem WebView2/PC aber nicht (wird weiß statt
transparent).

**Was jetzt anders ist:**
- **Echt schwebend, runde Ecken.** Das OS-Fenster wird wieder selbst rund
  geschnitten (SetWindowRgn), die Karte füllt es opak. Kein weißer Kasten mehr,
  alle vier Ecken sauber rund – verifiziert per echtem Bildschirm-Screenshot.
- **Mode-Liste als Palette.** Beim Aufklappen wächst das Panel und die 13 Modi
  füllen es als saubere Liste (statt klein in der Ecke zu schweben).
- **Opus-Schutz in der Polish-API.** Falls als Polish-Modell Opus 4.7/4.8
  eingestellt wird, wird `temperature` weggelassen (die akzeptieren das nicht
  mehr → sonst HTTP-400-Absturz). Standard (Haiku 4.5) unverändert.

## 2026-06-07 – Grundüberholung: hört auf zu buggen + neues Profi-Design

Das große Aufräumen. Zwei Ziele: nicht mehr ständig spinnen, und endlich
richtig gut aussehen. Beides erledigt.

**Was ständig kaputt war – und jetzt gefixt ist:**

- **Das Tool hat sich beim zweiten Start selbst lahmgelegt.** Wenn es schon
  lief (z.B. per Autostart) und man es nochmal startete, stritten sich beide um
  den Strg+Leer-Hotkey – Ergebnis: ein toter Zombie-Prozess und „Hotkey
  blockiert"-Fehler. Jetzt gibt es eine Türsteher-Sperre (Single-Instance): ein
  zweiter Start sagt freundlich „läuft schon" und beendet sich.
- **Der Aufnahme-Knopf hat sich verschluckt.** Schnell zweimal Strg+Leer und das
  Tool hing fest oder spuckte ein leeres Ergebnis aus (im Log: „REC start → stop
  in unter 1 Sekunde → 0 Zeichen"). Ursache: jeder Tastendruck startete einen
  eigenen Thread, die sich gegenseitig den Status zerschossen. Jetzt läuft alles
  sauber serialisiert (ein Schloss), Doppel-Tipper werden abgefangen, und ein
  versehentlich zu kurzer Stopp nimmt einfach weiter auf, statt wegzuwerfen.
- **Das erste Wort wurde manchmal abgeschnitten.** Es gibt jetzt einen kleinen
  Vorlauf-Puffer (~0,3 s vor dem Tastendruck), damit der Anfang nicht verloren
  geht.
- **„Strg+V" kam manchmal nicht an** (weil man ja noch Strg gedrückt hielt).
  Jetzt werden die Tasten vorher sauber losgelassen – das Einfügen klappt
  zuverlässig. Und dein vorheriger Zwischenablage-Inhalt wird danach
  wiederhergestellt.
- **Stilisierter Text wurde manchmal grundlos weggeworfen.** Der „keine
  KI-Ausrede"-Wächter hat zu scharf zugeschlagen und z.B. einen Justus-Spruch
  mit „literally" oder ein „Sorry, Meeting verschoben" fälschlich als Weigerung
  erkannt – und dann den rohen Text statt der schönen Übersetzung eingefügt.
  Jetzt prüft er nur noch die allererste Zeile auf echte Weigerungen; mitten im
  Text darf alles stehen.
- **Mikrofon-Ausfall killt nicht mehr alles.** Wird das Mikro getrennt/gewechselt,
  startet der Audio-Stream automatisch neu, statt still zu sterben.
- **Fenster-Geflacker beim Auf-/Zuklappen weg.** Die alte Trick-Technik für
  runde Ecken (Windows-Regionen) flackerte bei hoher Bildschirm-Skalierung und
  hatte ein Speicherleck. Komplett rausgeworfen – runde Ecken kommen jetzt rein
  über transparentes Fenster + CSS. Stabil, kein Geflacker.

**Was jetzt neu/besser ist:**

- **Der gewählte Modus bleibt erhalten.** Nach einem Neustart ist wieder der
  Modus aktiv, den du zuletzt benutzt hast (gespeichert in `settings.json`) –
  nicht mehr stur „Coding".
- **Live-Waveform während der Aufnahme.** Im Overlay tanzt jetzt eine echte
  Audiokurve, die auf deine Stimme reagiert (mit Peak-Anzeige) – man sieht
  sofort, dass das Mikro hört.
- **Komplett neues Design** im Stil moderner Profi-Tools (Raycast/Linear):
  ruhige, edle dunkle Glas-Karte, feine Akzent-Lichtkante oben in der Modus-
  Farbe, klares Logo, sauberer Modus-Picker mit Farbpunkten, sechs klar
  unterscheidbare Zustände (Laden/Bereit/Aufnahme/Transkribiert/Fertig/Fehler).
- **Schneller erster Start des Fensters.** Die Schrift kommt nicht mehr aus dem
  Internet (Google Fonts), sondern aus dem System – kein Lade-Hänger mehr.
- **Log wächst nicht mehr unbegrenzt** (rotiert bei 1 MB).

## 2026-06-06 – Dropdown-Fix, weniger Rand, mehr Farbe

**Was war kaputt:**
Das Dropdown-Menü öffnete sich unterhalb des 200px-Fensters und war deshalb
abgeschnitten – alle Modi ab dem dritten waren unsichtbar. Dazu: 16px weißer
Rand ringsrum, Hintergrund zu dunkel/grau.

**Was jetzt anders ist:**

- **Dropdown klappt vollständig auf.** Beim Öffnen vergrößert sich das Fenster
  dynamisch (170 → 520px), beim Schließen wieder zurück. Alle 13 Modi sichtbar.
- **Rand kleiner.** Margin von 16px auf 7px reduziert — kaum noch sichtbarer
  weißer Rand außen.
- **Farbiger Hintergrund.** Shell-Hintergrund ist jetzt ein dunkelblaues
  Gradient statt flach-grau. Der aktive Modus-Farbakzent strahlt als Ambient-
  Glow nach außen UND als subtiler Gradient oben im Panel rein.
- **Rand passt sich der Modus-Farbe an.** Der Border-Farbton wechselt mit dem
  gewählten Modus (color-mix mit Akzentfarbe).
- **Akzent-Stripe dicker und heller.** 3→4px, opacity 0.7→0.9, doppelter Glow.

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
