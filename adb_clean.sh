#!/bin/bash

# YakusaFire 

# List of packages to be removed
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

echo "--- Start Of Cleaning ---"

# Test connexion
if ! adb get-state 1>/dev/null 2>&1; then
    echo "Erreur : Smartphone not detected."
    exit 1
fi

for package in "${APPS[@]}"; do
    echo "$package : Removed"
    adb shell pm uninstall -k --user 0 "$package" > /dev/null 2>&1
done

echo "---"
echo "Cleaning finish."