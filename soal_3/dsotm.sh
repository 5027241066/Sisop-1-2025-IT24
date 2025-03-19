#!/bin/bash

# Fungsi untuk memberi suatu output kerika ada input Ctrl+C
cleanup() {
    echo -e "\n==========================================================================\n"
    exit 0
}

# Menangkap input Ctrl+C (SIGINT)
trap cleanup SIGINT

# Fungsi Speak to Me: Menampilkan afirmasi dari API setiap detik
speak_to_me() {

	clear
	echo -e "=============== MAOTD (Meaningful Affirmations of The Day) ===============\n"

	# Looping untuk menjalankan afirmasi satu persatu
	while true; do
		affirmation=$(curl -s https://www.affirmations.dev | jq -r '.affirmation')
		echo -n " 👉🏼"

		# For loop untuk print out afirmasi
		for ((i=0; i < ${#affirmation}; i++)); do
			echo -n "${affirmation:$i:1}"
			sleep 0.05
		done
		echo " ❤️‍🔥"
        	sleep 1
    	done
}

# Fungsi  On the Run: Menampilkan progress bar dengan persentase
on_the_run() {

    	clear
    	local progress=0

    	echo -e "================ ARIP (a Random Interval Progress Bar) =====================================================\n"
    	echo -e "LOADING BAR :\n"

	# Perulangan untuk membuat loading bar
    	while [ $progress -le 100 ]; do
        	# Membuat interval random antara 0.1 - 1 detik
        	sleep $(awk -v min=0.1 -v max=1 'BEGIN{srand(); print min+rand()*(max-min)}')
        	tput cuu 1 && tput el

		# Setiap bar akan mewakili 2% progress
		local bar_count=$((progress / 2))

        	# Print out progress bar
        	printf "[%-50s] %3d%%\n" "$(printf '▨%.0s' $(seq 1 $progress))" "$progress"

        	((progress+=2))

    	done
}

# Fungsi if else untuk mengecek pagi atau malam
day_or_night() {

	# Jam 06.00 - 17.59 (Pagi) dan jam 18.00 - 06.00 (Malam)
	if [[ $hour_now -ge 6 && $hour_now -lt 18 ]]; then
		echo "   | ☀️ (Day)"
	else
		echo "   | 🌙 (Night)"
	fi
}


# Fungsi Time:Menampilkan tanggal, bulan, tahun dan jam pada suatu tempat tertentu
world_time() {

	clear

	# Perulangan untuk menampilkan wilayah, jam, tanggal, dan keadaaan pagi atau malam secara live
	while true; do
		tput cup 0  0
		echo -e "\e[31m====================\e[0m WORLD LIVE TIME \e[31m====================================\e[0m"

		echo "Jakarta    "
        	echo -n "Date : $(TZ='Asia/Jakarta' date '+%d-%m-%Y')    Time : $(TZ='Asia/Jakarta' date '+%H:%M:%S')"
		local hour_now=$((10#$(TZ='Asia/Jakarta' date '+%H')))
		day_or_night
        	echo

        	echo "London   "
        	echo -n "Date : $(TZ='Europe/London' date '+%d-%m-%Y')    Time : $(TZ='Europe/London' date '+%H:%M:%S')"
		local hour_now=$((10#$(TZ='Europe/London' date '+%H')))
		day_or_night
        	echo

        	echo "New York   "
        	echo -n "Date : $(TZ='America/New_York' date '+%d-%m-%Y')    Time : $(TZ='America/New_York' date '+%H:%M:%S')"
		local hour_now=$((10#$(TZ='America/New_York' date '+%H')))
		day_or_night
        	echo

		echo "Sydney   "
		echo -n "Date : $(TZ='Australia/Sydney' date '+%d-%m-%Y')    Time : $(TZ='Australia/Sydney' date '+%H:%M:%S')"
		local hour_now=$((10#$(TZ='Australia/Sydney' date '+%H')))
		day_or_night
		echo

		echo "Cairo   "
		echo -n "Date : $(TZ='Africa/Cairo' date '+%d-%m-%Y')    Time : $(TZ='Africa/Cairo' date '+%H:%M:%S')"
		local hour_now=$((10#$(TZ='Africa/Cairo' date '+%H')))
		day_or_night

		sleep 1
    	done

}



#Fungsi pembuatan matriks acak dari simbol mata uang
money() {

	clear
    	tput civis

	# Deklarasi array simbol simbol
    	symbols=("💲" "€" "£" "¥" "¢" "₹" "₩" "₿" "₣" "₤" "₧" "₮" "₭" "₦" "₳")

	# Mendapatkan jumlah kolom dan baris dari terminal
	cols=$(tput cols)
    	lines=$(tput lines)

    	while true; do
		# Looping untuk setiap kolom
        	for ((i = 0; i < cols; i++)); do
            		# Memilih simbol secara acak
            		symbol=${symbols[$RANDOM % ${#symbols[@]}]}

            		# Memilih warna hijau dengan variasi brightness
            		color=$((RANDOM % 2 + 2))
            		printf "\e[1;3%dm%s\e[0m" "$color" "$symbol"
        	done
        	echo
        	sleep 0.15
    	done
}


brain_damage() {

    	clear
    	tput civis

	# Perulangan untuk melakukan program yang terus update
    	while true; do
        	clear
        	echo -e "\e[1;34m=========================================\e[0m"
        	echo -e "\e[1;32m          🖥️ SIMPLE TASK MANAGER        \e[0m"
        	echo -e "\e[1;34m=========================================\e[0m"

        	echo -e "\e[1;33mPID   USER     CPU%   MEM%   COMMAND\e[0m"
        	echo -e "\e[1;34m-----------------------------------------\e[0m"

        	# Menampilkan daftar proses dengan penggunaan CPU & Memori tertinggi
        	ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | head -10

        	echo -e "\e[1;34m=========================================\e[0m"
        	echo -e "\e[1;36m[Press CTRL+C to exit]\e[0m"

        	sleep 1
    	done
}



# Mengecek input argumen
if [[ "$1" == "--play=Speak to Me" ]]; then
	speak_to_me
elif [[ "$1" == "--play=On the Run" ]]; then
    	on_the_run
elif [[ "$1" == "--play=Time" ]]; then
    	world_time
elif [[ "$1" == "--play=Money" ]]; then
    	money
elif [[ "$1" == "--play=Brain Damage" ]]; then
    	brain_damage
else
    echo "Wrong input! Default Input : ./dsotm.sh --play=\"Nama Lagu\""
fi
