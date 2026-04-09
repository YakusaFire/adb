#!/bin/bash

# YakusaFire


key=0
echo "---"
echo "Taper '666' pour fermer la télécommande"
echo "---"
echo "Taper '501' pour obtenir les numéros de KeyEvent"
echo "---"
echo "Taper '1' pour déverouiller le téléphone"
echo "---"


while [ $key -ne 666 ]; do

    read -p "Rentré le numéro de KeyEvent à executer: " key >&2

    if [[ ! $key =~ ^[0-9]+$ ]]; then
        echo "Rentrer un nombre entier positif"
        echo ""
        key=0
        continue
    fi

    if [ $key -eq "501" ]; then
        cat keyevent.txt
        echo ""
    fi

    if [ $key -eq "1" ]; then

        adb shell input keyevent 224
        adb shell input swipe 500 1500 500 500 200
        read -p "Rentré le mot de passe: " mdp >&2
        adb shell input text "$mdp"
    fi

    if [ $key -eq "502" ]; then

        ./adb_clean.sh
    fi


    adb shell input keyevent $key
    echo ""

done
