#!/bin/bash
TODAY="$(date -d today '+%Y-%m-%d')"
MONTH="$(date -d "$D" '+%m')"
YEAR="$(date -d "$D" '+%Y')"

USER="Username"
PASS="Password"

FOLDER="/EJZ"


curl -A "Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:59.0) Gecko/20100101 Firefox/59.0" --cookie-jar cookie.txt --form pass=$PASS --form name=$USER https://www.ejz.de/index.php?action=login > /dev/null 2>&1
curl -A "Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:59.0) Gecko/20100101 Firefox/59.0" -b cookie.txt 'https://www.ejz.de/epaper/get.php?&datum='$TODAY'&ausgabe=&datei=EJZ_'$TODAY'&action=download' --output $FOLDER'/EJZ_'$TODAY'.pdf' > /dev/null 2>&1 &

sleep 10

mkdir -p $FOLDER'/'$YEAR'/'$MONTH
mv -f $FOLDER'/EJZ_'$TODAY'.pdf' $FOLDER'/'$YEAR'/'$MONTH'/EJZ_'$TODAY'.pdf'
