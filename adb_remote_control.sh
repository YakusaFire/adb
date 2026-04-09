#!/bin/bash

# YakusaFire


key=0
echo "---"
echo "Taper '1' pour afficher les commandes remote_control"
echo "---"


while [ $key -ne 666 ]; do

    read -p "Rentré le numéro de KeyEvent à executer: " key >&2

    if [[ ! $key =~ ^[0-9]+$ ]]; then
        echo "Rentrer un nombre entier positif"
        echo ""
        key=0
        continue
    fi

    if [ $key -eq "1" ]; then
        cat remote_control_key.txt
        echo ""
    fi

    if [ $key -eq "501" ]; then
        cat keyevent.txt
        echo ""
    fi

    if [ $key -eq "503" ]; then

        adb shell input keyevent 224
        adb shell input swipe 500 1500 500 500 200
        read -sp "Rentré le mot de passe: " mdp >&2
        adb shell input text "$mdp"
        echo ""
    fi

    if [ $key -eq "502" ]; then

        ./adb_clean.sh
        echo ""
    fi


    adb shell input keyevent $key
    echo ""

done
