#!/bin/bash

# YakusaFire
# Arg1: Destination directory

if [ $# -eq 0 ]; then
	DESTINATION="$HOME/Documents/ADB"
else
	DESTINATION="$1"
fi

DATE=$(date +%Y-%m-%d_%Hh%M)
DOSSIER_FINAL="$DESTINATION/$(adb shell getprop ro.config.marketing_name | sed "s/ /_/g" )_backup_$DATE"

echo "--- Backup ---"

mkdir -p "$DOSSIER_FINAL"

# List of folder, we need to save
DOSSIERS=("DCIM" "Pictures" "Download" "Music" "Movies" "Documents")

for folder in "${DOSSIERS[@]}"; do
    echo "Copy : $folder..."
    # We create the new folder
    mkdir -p "$DOSSIER_FINAL/$folder"
    # We pull
    adb pull "/sdcard/$folder/." "$DOSSIER_FINAL/$folder/"
done

echo "---"
echo "Backup complete"
echo "Your files are here : $DOSSIER_FINAL"