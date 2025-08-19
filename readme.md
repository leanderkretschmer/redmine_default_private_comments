# Redmine Default Private Comments

Ein Plugin für [Redmine](https://www.redmine.org/), das die Checkbox „Privater Kommentar“ beim Hinzufügen von Notizen standardmäßig aktiviert – sofern der Benutzer die Berechtigung dafür besitzt.

## Funktionen

- Checkbox „Privater Kommentar“ wird automatisch aktiviert
- Keine Änderungen am Rechtesystem von Redmine
- Kompatibel mit Redmine 5.x und 6.x

## Einstellungen

Ab Version 0.3.0 bietet das Plugin Konfigurationsmöglichkeiten im Adminbereich:

- Globale Aktivierung: Gesamtfunktion an-/abschalten
- Projektbasierte Aktivierung: Wenn aktiv, wirkt das Plugin nur in Projekten, in denen das Projektmodul „Default Private Comments“ aktiviert ist (Projekt → Einstellungen → Module)

## Installation

### 1. Docker / Containerfile

Füge den folgenden Block in dein Containerfile ein, um das Plugin direkt beim Image-Build einzubinden:

```
# Beispiel: redmine_default_private_comments installieren
RUN git clone -b master https://github.com/leanderkretschmer/redmine_default_private_comments plugins/redmine_default_private_comments \
    && cd plugins/redmine_default_private_comments \
    && git checkout <COMMIT_ID>
```

Hinweis: Ersetze `<COMMIT_ID>` durch einen festen Commit-Hash für reproduzierbare Builds.

### 2. Git-Klon in bestehendes Redmine-System

```
cd /pfad/zu/redmine/plugins
git clone https://github.com/leanderkretschmer/redmine_default_private_comments.git
```

Dann Redmine neu starten:

```
cd /pfad/zu/redmine
bundle install
RAILS_ENV=production bundle exec rake redmine:plugins
touch tmp/restart.txt  # Bei Verwendung von Passenger/Nginx
```

### 3. Release herunterladen und entpacken

1. Gehe zur [Release-Seite des Projekts](https://github.com/leanderkretschmer/redmine_default_private_comments/releases)
2. Lade das gewünschte Archiv herunter (`.zip` oder `.tar.gz`)
3. Entpacke das Plugin in das Redmine-Pluginverzeichnis:

```
unzip redmine_default_private_comments-v1.0.0.zip
mv redmine_default_private_comments /pfad/zu/redmine/plugins/
```

Danach wie oben: `bundle install` und Redmine neu starten.

## Kompatibilität

| Redmine-Version | Getestet |
|------------------|----------|
| 6.x              | Ja       |
| 5.x              | Ja       |
| < 5.x            | Nicht getestet |

## Lizenz

MIT – siehe Datei `LICENSE`.

## Feedback & Beiträge

Fehler oder Verbesserungsvorschläge bitte über GitHub-Issues oder Pull Requests einreichen:
https://github.com/leanderkretschmer/redmine_default_private_comments/issues

<!--
Ende README.md
-->
