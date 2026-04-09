#!/bin/bash

# YakusaFire 

# List of packages to be removed
APPS=(
    # --- Social Networks ---
    "com.facebook.katana"       			 	# Facebook
    "com.facebook.system"        				# Service FB
    "com.facebook.appmanager"    				# Gestionnaire FB
    "com.facebook.services"      				# Services FB
    "com.linkedin.android"      			 	# LinkedIn
    "com.microsoft.skydrive"     				# OneDrive
    "com.netflix.mediaclient"    				# Netflix
	"com.microsoft.skype.teams"					# Skype
	"com.amazon.mShop.android.shopping"			# Amazon
    
    # --- Samsung Bloatware ---
    "com.samsung.android.bixby.agent"      		# Bixby
	"com.samsung.android.bixby.wakeup"
	"com.samsung.android.spay"
	"com.samsung.android.kidsinstaller"
    "com.samsung.android.app.spage"        		# Samsung Daily / Free
    "com.samsung.android.kidsinstaller"    		# Child Mode
    "com.samsung.android.app.tips"         		# Samsung Tips
    "com.samsung.android.app.watchmanagerstub" 	# Galaxy Watch
    "com.samsung.android.messaging"        		# SMS Samsung
    "com.sec.android.app.sbrowser"         		# Browser Samsung
    "com.samsung.android.wellbeing"        		# Digital wellbeing
    
    # --- Game ---
    "com.samsung.android.game.gamehome"    		# Game Launcher
    "com.samsung.android.game.gametools"   		# Game Tools
    "com.samsung.android.game.gos"         		# Game Optimizing Service (parfois controversé)

	# --- Xiaomi ---
	"com.miui.analytics"
	"com.miui.msa.global"
	"com.miui.videoplayer"
	"com.miui.player"
	"com.xiaomi.joyose"

	# --- Google ---
	"com.google.android.apps.tachyon"
	"com.google.android.videos"
	"com.google.android.music"
	"com.google.android.apps.magazines"
)

echo "--- Début de la supression des package ---"

# Test connexion
if ! adb get-state 1>/dev/null 2>&1; then
    echo "Erreur : Smartphone not detected."
    exit 1
fi

for package in "${APPS[@]}"; do
    echo "$package : Removed"
    adb shell pm uninstall -k --user 0 "$package" > /dev/null 2>&1
done

echo "--- Tout les packages ont été supprimé ---"



echo ""
echo "--- Nettoyage repertoire ---"

# Fichiers temporaires
TMP_PHONE="/tmp/phone_$RANDOM$RANDOM"
TMP_KEEP="/tmp/keep_$RANDOM$RANDOM"
TMP_SUPPR="/tmp/supr_$RANDOM$RANDOM"

# Liste avec séparateur |
directorys="Android|DCIM|Documents|Download|Movies|Music|Notifications|Pictures|SuperNDS"

echo "Analyse en cours des répertoires non nécessaire"

# 1. On stocke les dossiers du téléphone dans un fichier
adb shell ls -1 /sdcard/ | tr -d '\r' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' > "$TMP_PHONE"

# 2. On stocke ta liste de sauvegarde dans un autre fichier
echo "$directorys" | tr '|' '\n' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' > "$TMP_KEEP"

# 3. LA NOUVELLE LOGIQUE (grep)
# -v : Inverser (garder ce qui NE correspond PAS)
# -F : Texte brut (pas de regex)
# -x : Ligne entière exacte
# -f : Utiliser le fichier de référence
grep -v -F -x -f "$TMP_KEEP" "$TMP_PHONE" > "$TMP_SUPPR"


echo "--- DOSSIERS INTRUS À SUPPRIMER ---"
# Si le fichier est vide ou n'existe pas (grep n'a rien trouvé)
if [ ! -s "$TMP_SUPPR" ]; then
    echo "Aucun dossier à supprimer. Ton téléphone est propre !"

else
    cat -e "$TMP_SUPPR"
    echo "-----------------------------------"

    while read -r folder; do

        if [ -n "$folder" ]; then
            echo "Suppression de : /sdcard/$folder"
            adb shell rm -rf "/sdcard/$folder"
        fi

    done < "$TMP_SUPPR"
fi


rm -f "$TMP_PHONE" "$TMP_KEEP" "$TMP_SUPPR"
echo "---"
echo "Opération terminée."
echo "---"
echo "Cleaning finish."
exit 0
