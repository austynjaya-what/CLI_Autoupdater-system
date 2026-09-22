#!/usr/bin/env bash
sleep 1
echo "Welcome to the Setup Script"
sleep 1
echo "This script will help you set up the autoupdater script"
sleep 1
echo "Please answer the questions regarding the system truthfully, if not the script might refuse to work properly"
sleep 1
touch static/mute.sh
chmod +x static/mute.sh
sudo chown "$USER:$USER" static/mute.sh
chmod +x static/mute.sh
while true; do
read -r -p "If you are ready, Click enter:"
while true; do
read -r -p "What should I call you? (This is for the script to know who is using it, and to make it more personal)" c
if [[ -n "$c" ]]; then
    echo "c=$c" >> static/mute.sh
    echo "Hello $c, Let's get you up to speed!"
    break
else
    echo "Please enter a valid name"
fi
done
echo "What is your distro from the following list?"
echo "1. Debian  2. Ubuntu  3. Fedora  4. Arch  5. Void Linux  6. Kubuntu  7. Manjaro"
read -r -p "Enter your desired distro's number here:" distro
case $distro in
    1)
        control="deb"
        echo "d=$control" >> static/mute.sh
        break
        ;;
    2)
        control="ubt"
        echo "d=$control" >>  static/mute.sh
        break
        ;;
    3)
        control="fed"
        echo "d=$control" >> static/mute.sh
        break
        ;;

    4)  control="arh"
        echo "d=$control" >> static/mute.sh
        break
        ;;

    5)
        control="vod"
        echo "d=$control" >> static/mute.sh
        break
        ;;

    6)
        control="kub"
        echo "d=$control" >> static/mute.sh
        break
        ;;
    
    7)
        control="man"
        echo "d=$control" >> static/mute.sh
        break
        ;;
    *)
        sleep 1
        echo "Sorry, the option you provided is invalid"
        ;;

esac
done
sleep 2
while true; do
read -r -p "Would you like to install flatpak support?(y/n):" flatpak
case $flatpak in
    y | Y)
        echo "You chose to include flatpak in the autoupdate process"
        flatpak="y"
        echo "flatpak=$flatpak" >> static/mute.sh
        break
        ;;
    
    n | N)
        echo "Looks like you don't want to include flatpak in autoupdate process"
        flatpak="n"
        echo "flatpak=$flatpak" >> static/mute.sh
        break
        ;;
    
    *)
        echo "Your option is invalid"
        sleep 1
        ;;
esac
done
#NOTE! For Flatpak repo modification, You might need to do it manually if you already installed flatpak into your system! Sorry.
if [ "$flatpak" == "y" ]; then
    case $control in
        ubt)
            sudo apt install flatpak gnome-software-plugin-flatpak -y
            flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
            sleep 1
            ;;
        
        deb)
            sudo apt install flatpak -y
            while true; do
            read -r -p "Do you use KDE or GNOME? (1. KDE, 2. GNOME 3. Neither)" tgv
            if [[ $tgv == "1" ]]; then
                echo "Installing KDE Backends for Flatpak"
                sudo apt install plasma-discover-backend-flatpak -y
                break
            elif [[ $tgv == "2" ]]; then
                echo "Installing Gnome Backends for Flatpak"
                sudo apt install gnome-software-plugin-flatpak -y
                break
            elif [[ $tgv == "3" ]]; then
                echo "Not installing any backends for flatpak..."
                sleep 1 
                break
            else
                echo "Error in inputting your answer, please answer again"
            fi
            done
            flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
            sleep 1
            ;;
        
        fed)
            flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
            sleep 1
            ;;
        
        arh)
            sudo pacman -S flatpak --noconfirm
            flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
            sleep 1
            ;;
        
        vod)
            sudo xbps-install -Sy flatpak
            flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
            sleep 1
            ;;

        kub)
            sudo apt install flatpak kde-config-flatpak -y
            flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
            sleep 1
            ;;
        man)
            sudo pacman -S flatpak
            flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
            sleep 1
            ;;
    esac
    sleep 1
    echo "Flatpak support integrated successfully"
    sleep 1
    echo "NOTE: If you installed Flatpak for the first time for this system, you will need to log out or restart your system for the changes to take place!"
    sleep 1
    echo "That is all, the setup is complete!"

elif [ "$flatpak" == "n" ]; then
    echo "You chose not to include flatpak in the autoupdate process"
    sleep 1
    echo "That is all, the setup is complete!"
    read -r -p "Press Any Key to Exit the setup process and finally enjoy your autoupdater!"
    exit 0
fi