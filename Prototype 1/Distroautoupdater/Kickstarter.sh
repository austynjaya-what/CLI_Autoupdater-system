#!/usr/bin/env bash
sleep 1
echo "Kickstarter Script for the Universal Distro Autoupdater System!"
sleep 1
echo "This ensures the script is writable by the local account user"
sleep 1
chmod +x Payload.sh
chmod +x setup.sh
sudo chown "$USER:$USER" Payload.sh
sudo chown "$USER:$USER" setup.sh
chmod -R 777 Distroautoupdater -type f >> /dev/null 2>&1
sleep 1
echo "All files provided are now readable and writable by the local account user!"
sleep 1
read -r -p "Press any key to begin your adventure!"
sleep 2
clear
sudo bash Payload.sh


