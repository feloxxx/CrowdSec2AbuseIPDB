#!/bin/bash

# Konfiguration
API_KEY="dein_abuseipdb_api_key"

# Datum und Uhrzeit der letzten Stunde erfassen
since=$(date --date='1 hour ago' '+%Y-%m-%dT%H:%M:%S')

# Hole die geblockten IP-Adressen und deren Gründe der letzten Stunde
# Annahme: cscli gibt Datum, IP und Grund in einer durchsuchbaren Form aus
BLOCKED_IPS=$(cscli decisions list --since "$since" --output csv | awk -F, 'NR > 1 {print $2","$4}')

# Melde jede IP mit Grund an AbuseIPDB
IFS=$'\n'
for entry in $BLOCKED_IPS; do
    ip=$(echo $entry | cut -d',' -f1)
    reason=$(echo $entry | cut -d',' -f2)
    if [ -n "$ip" ]; then
        # Übersetze den Grund in eine Kategorie-ID (AbuseIPDB-spezifisch)
        # Beispiel: Unauthorisierter Zugriff könnte Kategorie 22 sein
        category="22"  # Diese Zeile an den spezifischen Grund anpassen

        response=$(curl -s -G https://api.abuseipdb.com/api/v2/report \
            --data-urlencode "ip=$ip" \
            --data-urlencode "categories=$category" \
            --data-urlencode "comment=Blockiert durch CrowdSec: $reason" \
            -d maxAgeInDays=90 \
            -H "Key: $API_KEY" \
            -H "Accept: application/json")
        echo "Meldung für $ip: $response"
    fi
done
unset IFS
