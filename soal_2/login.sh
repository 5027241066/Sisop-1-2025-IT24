#!/bin/bash

data_file="/data/player.csv"
salt="trakea_salt"


echo "======= Player Login ======="


while true; do
	# Meminta input email dan password
	read -p "Enter email: " email
	read -s -p "Enter password: " password
	echo ""

	# Ambil hash dari database
	stored_hash=$(grep "^$email," "$data_file" | cut -d',' -f3)

	# Hash password input user dengan salt
	input_hash=$(echo -n "$salt$password" | sha256sum | awk '{print $1}')

	# Cek apakah email dan password cocok dg hash
	if [[ "$input_hash" == "$stored_hash" ]]; then
    		username=$(grep "^$email," "$data_file" | cut -d',' -f2)
    		echo "✅ Login successful! Welcome, $username!"
	else
    		echo "❌ Invalid email or password!"
    		exit 1
	fi
done
