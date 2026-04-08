#!/bin/bash

# YakusaFire 

# Liste des paquets à supprimer (tu peux en commenter avec un #)
APPS=(
    # --- Social Networks ---
    "com.facebook.katana"        # Facebook
    "com.facebook.system"        # Service FB
    "com.facebook.appmanager"    # Gestionnaire FB
    "com.facebook.services"      # Services FB
    "com.linkedin.android"       # LinkedIn
    "com.microsoft.skydrive"     # OneDrive
    "com.netflix.mediaclient"    # Netflix
    
    # --- Samsung Bloatware ---
    "com.samsung.android.bixby.agent"      # Bixby
    "com.samsung.android.app.spage"        # Samsung Daily / Free
    "com.samsung.android.kidsinstaller"    # Mode Enfants
    "com.samsung.android.app.tips"         # Astuces Samsung
    "com.samsung.android.app.watchmanagerstub" # Galaxy Watch (si tu n'en as pas)
    "com.samsung.android.messaging"        # SMS Samsung (si tu utilises Google Messages)
    "com.sec.android.app.sbrowser"         # Navigateur Samsung (si tu utilises Chrome)
    "com.samsung.android.wellbeing"        # Bien-être numérique (optionnel)
    
    # --- Game ---
    "com.samsung.android.game.gamehome"    # Game Launcher
    "com.samsung.android.game.gametools"   # Game Tools
    "com.samsung.android.game.gos"         # Game Optimizing Service (parfois controversé)
)

echo "--- Début du nettoyage du Samsung S25 ---"

# Vérification connexion
if ! adb get-state 1>/dev/null 2>&1; then
    echo "Erreur : Téléphone non détecté."
    exit 1
fi

for package in "${APPS[@]}"; do
    echo "Suppression de : $package"
    # On utilise '|| true' pour que le script continue même si l'app est déjà supprimée
    adb shell pm uninstall -k --user 0 "$package" > /dev/null 2>&1
done

echo "---"
echo "Nettoyage terminé ! Ton téléphone devrait respirer un peu mieux."
echo "Note : Les applications n'apparaîtront plus, mais reviendront après un 'Reset d'usine'."