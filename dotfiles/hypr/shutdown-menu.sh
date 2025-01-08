#!/bin/bash

choice=$(echo -e "Shutdown\nReboot\nLogout" | wofi --dmenu --prompt "Power Menu" --width 300 --height 200)

case $choice in
    "Lock") hyprlock ;;
    "Shutdown") systemctl poweroff ;;
    "Reboot") systemctl reboot ;;
    "Logout") hyprctl dispatch exit ;;
    *) exit 1 ;; # In case of an invalid choice or menu close
esac
