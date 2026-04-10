#!/bin/bash

# YakusaFire


key=0
echo "---"
echo "Press '1' for see remote_control commands"
echo "---"


# Loop of remote_control
while [ $key -ne 666 ]; do


    read -p "Enter the KeyEvent number: " key >&2


    # shielding for only interger
    if [[ ! $key =~ ^[0-9]+$ ]]; then
        echo "Enter a positive integer"
        echo ""
        key=0
        continue
    fi


    # Print the remote_control commands
    if [ $key -eq "1" ]; then
        cat remote_control_key.txt
        echo ""
        continue
    fi


    # Print keyevent
    if [ $key -eq "501" ]; then
        cat keyevent.txt
        echo ""
    fi


    # Unlock the smartphone
    if [ $key -eq "503" ]; then

        adb shell input keyevent 223
        adb shell input keyevent 224
        adb shell input swipe 500 1500 500 500 200
        read -sp "Rentré le mot de passe: " mdp >&2
        adb shell input text "$mdp"
        echo ""
    fi


    # Launch adb_clean.sh script
    if [ $key -eq "502" ]; then

        read -p "You realy want to clean your smartphone(Y/N): " resp_502
        if [ "$resp_502" == "Y" ] || [ "$resp_502" == "y" ]; then
            ./adb_clean.sh
            echo ""
            continue

        else
            echo "---"
            echo "Cancel cleaning"
            echo "---"

        fi
    fi


    # Launch adb_backup.sh script
    if [ $key -eq "504" ]; then
        
        read -p "You realy want to do backup (Y/N): " resp_504
        if [ "$resp_504" == "Y" ] || [ "$resp_504" == "y" ]; then
            ./adb_backup.sh
            echo ""
            continue

        else
            echo "---"
            echo "Cancel backup"
            echo "---"

        fi
    fi



    # Do event and print what it does
    adb shell input keyevent $key
    cat keyevent.txt | grep "^$key" | cut -d ">" -f 3
    echo ""



done
exit 0
