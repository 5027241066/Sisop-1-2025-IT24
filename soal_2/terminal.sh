#!/bin/bash

data_file="data/player.csv"
mkdir -p data
[ ! -f "$data_file" ] && touch "$data_file"

while true; do
    clear
    echo "========================="
    echo "      ARCAEA TERMINAL    "
    echo "========================="
    echo "1. Register New Account"
    echo "2. Login to Existing Account"
    echo "3. Exit"
    echo "========================="
    read -p "Enter option [1-3]: " option

    case $option in
        1) bash register.sh ;;
        2) bash login.sh ;;
        3) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid option, try again!"; sleep 1 ;;
    esac
done
