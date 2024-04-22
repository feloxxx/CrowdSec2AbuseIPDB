Um ein Shell-Skript zu erstellen, das stündlich die von CrowdSec in der letzten Stunde geblockten IP-Adressen erfasst und zusammen mit dem Blockierungsgrund an AbuseIPDB meldet, folge diesen Schritten:
1. Zugang und Informationen

Du benötigst Zugriff auf die CrowdSec-Befehlszeilen-Tools (cscli) und einen gültigen API-Key von AbuseIPDB.
2. Shell-Skript schreiben

Das Skript nutzt die cscli-Befehle, um die Daten zu extrahieren, und curl, um die Daten an AbuseIPDB zu senden.

3. Das Skript ausführbar machen

Mache das Skript ausführbar mit:
chmod +x /pfad/zu/deinem/skript.sh

4. Cronjob einrichten

Um das Skript stündlich auszuführen, bearbeite den Crontab mit dem Befehl crontab -e und füge die folgende Zeile hinzu:

0 * * * * /pfad/zu/deinem/skript.sh

Hinweise

    API-Key Sicherheit: Bewahre den AbuseIPDB API-Key sicher auf und vermeide es, ihn direkt im Skript zu speichern.
    Anpassung der Kategorien: Die Kategorie muss basierend auf dem Grund der Blockierung von CrowdSec angepasst werden. Überprüfe die Kategorie-Codes auf der AbuseIPDB-Website und passe sie entsprechend an.
    Prüfung und Tests: Teste das Skript zunächst in einer kontrollierten Umgebung, um sicherzustellen, dass die Daten korrekt erfasst und übermittelt werden.
    Datenschutz und Compliance: Überprüfe, ob das Melden von IP-Adressen an AbuseIPDB mit den Datenschutzrichtlinien deiner Organisation und deiner Region übereinstimmt.
