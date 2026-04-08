#!/bin/bash

# YakusaFire

key=0
echo "---"
echo "Taper '666' pour fermer la télécommande"
echo "---"
echo "Taper '501' pour obtenir les numéros de KeyEvent"
echo "---"

while [ $key -ne 666 ]; do

    read -p "Rentré le numéro de KeyEvent à executer: " a >&2

    if [[ ! $a =~ ^[0-9]+$ ]]; then
        echo "Rentrer un nombre entier positif"
        echo ""
        key=0
        continue
    fi

    if [ $key -eq "501" ]; then
        cat keyevent.txt
        echo ""
    fi

    adb shell input keyevent $key
    echo ""

done