# pre-push Verhaltensproben

`testrun.sh` sammelt die Verhaltensproben fuer `.githooks/pre-push` in einem
Aufruf — ohne echten Push: die Werte-Zeile wird von Hand uebergeben, so wie
git sie beim Hochladen an den Hook schicken wuerde. Nur Lesen, der Git-Stand
bleibt unangetastet.

## Aufruf

Aus dem Projektordner (Git-bash):

```console
bash tools/githooks-test/testrun.sh
```

## Proben

| Probe | Eingabe                                                             | Erwartung           |
| ----- | ------------------------------------------------------------------- | ------------------- |
| 1     | saubere Werte-Zeile (LF, wie echtes git push)                       | Durchgang, Abgang 0 |
| 2     | Werte-Zeile mit CR-Endrest (Windows-Pruefstrecke)                   | Durchgang, Abgang 0 |
| 3     | Fernwert unlesbar (Text statt 40-stelliger Hex-Revision)            | Sperre, Abgang 1    |
| 4     | Fernwert zu kurz (Hex-Folge unzureichend)                           | Sperre, Abgang 1    |
| 5     | gitleaks nicht auffindbar (GITLEAKS_BIN/LOCALAPPDATA/HOME auf Temp) | Sperre, Abgang 1    |

Hintergrund: vor dem Umbau vom 22.10.2026 lief der Hook unter
Windows-Pruefstrecken in einen stillen Leerlauf (0 Commits gescannt,
gruene Meldung) — siehe CHANGELOG-Sektion "git-hooks" vom 22.10.2026 und
COMPACTIONS-Block "Abend (3)".
