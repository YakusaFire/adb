#!/bin/bash

# YakusaFire


key=0
echo "---"
echo "Taper '1' pour afficher les commandes remote_control"
echo "---"


# Boucle de la télécommande
while [ $key -ne 666 ]; do


    read -p "Rentré le numéro de KeyEvent à executer: " key >&2


    # Blindage seulement entier positif
    if [[ ! $key =~ ^[0-9]+$ ]]; then
        echo "Rentrer un nombre entier positif"
        echo ""
        key=0
        continue
    fi


    # Affiche les commandes de la télécommande
    if [ $key -eq "1" ]; then
        cat remote_control_key.txt
        echo ""
    fi


    # Affiche les keyevent ADB
    if [ $key -eq "501" ]; then
        cat keyevent.txt
        echo ""
    fi


    # Permet de débloquer le téléphone
    if [ $key -eq "503" ]; then

        adb shell input keyevent 223
        adb shell input keyevent 224
        adb shell input swipe 500 1500 500 500 200
        read -sp "Rentré le mot de passe: " mdp >&2
        adb shell input text "$mdp"
        echo ""
    fi


    # Lance le script de nétoyage du téléphone
    if [ $key -eq "502" ]; then

        read -p "Vous voulez vraiment clean votre téléphone (Y/N): " resp_502
        if [ "$resp_502" == "Y" ] || [ "$resp_502" == "y" ]; then
            ./adb_clean.sh
            echo ""
            continue

        else
            echo "---"
            echo "Annulation du nettoyage"
            echo "---"

        fi
    fi


    # Faire une backup
    if [ $key -eq "504" ]; then
        
        read -p "Vous voulez vraiment effectuer une backup (Y/N): " resp_504
        if [ "$resp_504" == "Y" ] || [ "$resp_504" == "y" ]; then
            ./adb_backup.sh
            echo ""
            continue
        else
            echo "---"
            echo "Annulation de la backup"
            echo "---"



    # Réalise l'event et affiche ce qu'il fait.
    adb shell input keyevent $key
    cat keyevent.txt | grep "^$key" | cut -d ">" -f 3
    echo ""



done
exit 0
