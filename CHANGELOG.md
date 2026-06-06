# AIbersetzer – Changelog

In Laiensprache: was hat sich am Sprache-zu-Text-Übersetzer geändert und warum.

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
