#!/bin/bash

DESTINATION="$HOME/Documents/PROJET_ADB"
DATE=$(date +%Y-%m-%d_%Hh%M)
DOSSIER_FINAL="$DESTINATION/backup_$DATE"

echo "--- Sauvegarde ---"

mkdir -p "$DOSSIER_FINAL"

# Liste des dossiers à sauvegarder (ceux qui sont accessibles)
DOSSIERS=("DCIM" "Pictures" "Download" "Music" "Movies" "Documents")

for folder in "${DOSSIERS[@]}"; do
    echo "Copie de : $folder..."
    # On crée le sous-dossier sur le PC pour que ce soit propre
    mkdir -p "$DOSSIER_FINAL/$folder"
    # On pull le contenu
    adb pull "/sdcard/$folder/." "$DOSSIER_FINAL/$folder/"
done

echo "---"
echo "Sauvegarde terminée (les dossiers protégés ont été ignorés)."
echo "Tes fichiers sont ici : $DOSSIER_FINAL"