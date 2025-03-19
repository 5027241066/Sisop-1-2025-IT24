!/bin/bash

data_file="/data/player.csv"
salt="trakea_salt"

mkdir -p /data
touch "$data_file"

# Input email dan cek formatnya
echo "====== Player Registration ======"

while true; do
	read -p "Enter email : " email

	# Cek format email
	if [[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then

		# Jika format benar, cek apakah sudah terdaftar
        	if grep -q "^$email," "$data_file"; then
            		echo "⚠️ Email is already registered, try another email!"
        	else
            		break
        	fi
    	else
        	echo "⚠️ Invalid email format! It must contain '@' and '.'"
    	fi
done

# Input usname
read -p "Enter username: " username

# Input password dan cek formatnya
while true; do
    	read -s -p "Enter password: " password
    	echo
    	read -s -p "Confirm password: " password2
    	echo


    	if [[ "$password" != "$password2" ]]; then
        	echo "❌ Passwords do not match!"
    	elif [[ ${#password} -lt 8 ]]; then
        	echo "❌ Password must be at least 8 characters long!"
    	elif ! [[ "$password" =~ [A-Z] ]]; then
        	echo "❌ Password must contain at least one uppercase letter!"
    	elif ! [[ "$password" =~ [a-z] ]]; then
        	echo "❌ Password must contain at least one lowercase letter!"
    	elif ! [[ "$password" =~ [0-9] ]]; then
        	echo "❌ Password must contain at least one number!"
    	else
    	    	break
    	fi
done

# Memberi hash pada passwd
hash_password=$(echo -n "${salt}${password}") | sha256um | awk '{print $1}')

# Menambahkan informasi email, username, dan password ke data_file tanpa menghapus isi sebelumnya
echo "$email,$username,$hash_password" >> "$data_file"
echo "✅ Registration successful!"
