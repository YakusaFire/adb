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


TMP_SUPPR="/tmp/dossier_supr_$RANDOM$RANDOM"

directorys="Android DCIM Documents Download Movies Music Notifications Pictures SuperNDS"
folders=$(adb shell ls /sdcard/ | tr -d '\r')

{
    # 2. On affiche les dossiers distants
    echo "$folders"
    
    # 3. On transforme les espaces de ta variable en retours à la ligne
    echo "$directorys" | tr ' ' '\n'

} | sort | sed '/^$/d' | uniq -u > $TMP_SUPPR

tr '\n' ' ' < "$TMP_SUPPR"


for folder in $(cat $TMP_SUPPR$); do
    adb shell rm -rf /sdcard/$folder
done

rm $TMP_SUPPR


echo "---"
echo "Cleaning finish."
exit 0
