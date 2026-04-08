# Commandes ADB
## Les bases

adb devices 								-> Affiche les appareils connectés  
adb help									-> Affiche liste des commandes  
adb connect 								-> Doit être sur le même wifi et avoir activer l'option Débogage sans fil   -> Faire adb tcpip 5555 en USB puis [IP]:5555  


## Allumé/Eteindre
adb kill-server 							-> Arrete le serveur ADB  
adb start-server 							-> Relance le server ADB  


## Envoie de données
adb push [source_pc] [destination_tel]		-> Envoie un fichier sur le téléphone  
adb pull [source_tel] [destination_pc]		-> Copie un fichier du téléphone vers le pc  


## Installtation de package
adb install [nom_du_fichier.apk]			     -> Installe l'APK  
											-> -r Ecrase l'ancienne version  
adb uninstall [nom_du_package]				-> Désinstalle l'application  
adb shell pm list packages -f					-> Liste des packages  


## Redémarrage
adb reboot									-> Redémarre le téléphone  
adb reboot recovery							-> Redémarre en mode Recovery  
adb reboot bootloader						-> Redémarre en mode Bootloader  


adb shell screencap -p /sdcard/[nom_fichier]-> Prendre une capture d'écran  
adb shell input keyevent					-> Simule un appui de touche  


adb logcat									-> Affiche les logs









