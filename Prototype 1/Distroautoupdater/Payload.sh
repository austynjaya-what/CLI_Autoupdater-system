#!/usr/bin/env bash
if [ "$USER" != "root" ]; then
    sudo "$0" "$@"
fi
echo "Universal Distro Auto Updater"
echo "Prototype Build 01 Made by: Austyn Jaya"
echo "Not for direct use or post, please contact the author for permission to use this script."
sleep 1
if [ ! -f "static/mute.sh" ]; then
echo "Configuration file N/A, Beginning setup process..." 
sleep 1
a="static/setup.sh"
bash "$a" || echo "FATAL ERROR: Setup failed due to  the setup file being missing or being incorrectly placed" && exit 1
exit 0
fi
if [ "$(find updatescripts -type f >> /dev/null 2>&1 | wc -l)" -eq 0 ]; then
    sleep 1
else
    echo "Update scripts are N/A, This script will close, do not use until already fixed, you can get a backup copy of the scripts from github"
    exit 1
fi
#Line 23 is necessary Lol, remove it and bye bye.
source static/mute.sh
echo "Hello $c, Welcome to the Universal Distro Autoupdater system, what would you like to do?"
while true; do
echo "1. Update the system fully"
echo "2. Autoremove Unused packages"
echo "3. Exit"
read -r -p "Please enter your choice (1-3): " choice
#Below is the AUtoupdating part of the system!
case $choice in
    1) echo "You chose to update the system fully"
       sleep 1
       if [[ $flatpak == y ]] ; then
            sudo flatpak update -y 
        else
            echo "Flatpak Update is disabled, skipping..."
            sleep 1
        fi
        sleep 1
       if [[ $d == deb ]] || [[ $d == ubt ]] || [[ $d == kub ]]; then
           sleep 1
           sudo apt update 
           sudo apt upgrade -y
           break
       elif [[ $d == fed ]] ; then
            sleep 1
            sudo dnf update -y
            break
         elif [[ $d == arh ]] ; then
            sleep 1
            sudo pacman -Syu --noconfirm 
            break
        elif [[ $d == vod ]] ; then
            sleep 1
            sudo xbps-install -Syu 
            break
        else
            echo "Sorry, the option set is invalid"
            sleep 1
            exit 1
        fi
        exit 0
        ;;
    2) echo "You chose to autoremove unused packages"
       sleep 1
        if [[ $d == deb ]] || [[ $d == ubt ]] || [[ $d == kub ]]; then
            sleep 1
            sudo apt autoremove -y 
            sleep 1
        elif [[ $d == fed ]] ; then
            sleep 1
            sudo dnf autoremove -y 
            sleep 1
        elif [[ $d == arh ]] ; then
            sleep 1
            sudo pacman -Rns "$(pacman -Qdtq)" --noconfirm
            sleep 1 
        elif [[ $d == vod ]] ; then
            sleep 1
            sudo xbps-remove -O 
            sleep 1
        else
            echo "Sorry, the option you provided is invalid"
            sleep 1
        fi
        read -p "Press any key to exit"
        exit 0
        ;;
    3) echo "You chose to exit the script"
        exit 0
        ;;
    *) echo "Invalid option, please try again."
esac
done
