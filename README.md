# Table of Contents
- Soal 1
	- a. Banyak Buku yang Dibaca oleh Chris Hemsworth
	- b. Rata-rata Pembaca Menggunakan Tablet
	- c. Pembaca yang Memberi Rating Tertinggi
 	- d. Genre Buku Paling Popular di Asia
- Soal 2
	- a. First Step in a New World
 	- b. Radiant Genesis
  	- c. Unceasing Spirit
  	- d. The Eternal Realm of Light
  	- e. The Brutality of Glass
  	- f. In Grief and Great Delight
- Soal 3
	- a. Speak To Me
	- b. On The Run
	- c. Time
	- d. Money
 	- e. Brain Damage 
- Soal 4
	- a. Melihat summary dari data
 	- b. Mengurutkan Pokemon berdasarkan data kolom
  	- c. Mencari nama Pokemon tertentu
  	- d. Mencari Pokemon berdasarkan filter nama type
  	- e. Error handling
  	- f. Help screen yang menarik

# Soal 1
Membuat file poppo_siroyo.sh
```
touch poppo_siroyo.sh
```
Menginstall file reading_data.csv
```
wget "https://drive.usercontent.google.com/u/0/uc?id=1l8fsj5LZLwXBlHaqhfJVjz_T0p7EJjqV&export=download" -O reading_data.csv
```
### a. Banyak Buku yang Dibaca oleh Chris Hemsworth
Menggunakan awk untuk mencari “Chris Hemsworth” dan menghitung buku yang dibacanya.
```
awk -F, '{
        if ($2 == "Chris Hemsworth") {
            count++
        } else {
            count=count
        }
    }
    END {print "Chris Hemsworth membaca", count, "buku.";}' reading_data.csv
```
Mencari "Chris Hemsworth" di column 2 kemudian menghitung berapa kali nama tersebut muncul untuk mengetahui berapa buku yang telah dibaca.
- ```if ($2 == "Chris Hemsworth") { count++}``` jika pada column 2 terdapat "Chris Hemsworth" maka akan "count" ditambahkan 1.
- ```count=count``` selain Chris Hemsworth count akan tetap sama.

![image](https://github.com/user-attachments/assets/30674467-06b2-4349-adf9-be4ab652ee60)


### b. Rata-rata Pembaca Menggunakan Tablet
Menghitung rata-rata pembaca buku yang menggunakan media tablet.
Diketahui Device terdapat pada column H/8 dan Reading Duration pada column F/6.
```
awk -F, '{if ($8 == "Tablet") {total += $6; count++}} END {print "Rata-rata durasi membaca dengan Tablet adalah", total/count, "menit."}' reading_data.csv
```
- ```$8 -- "Tablet" total += $6``` untuk mencari pada column 8 yang membaca menggunakan tablet kemudian melihat pada column 6 dan memasukkan angka ke dalam variabel "total".
- ```count++``` menambah tiap pengulangan pengguna tablet ke dalam variabel "total".
- ```total/count``` untuk menghitung rata-rata dari variabel "total" dibagi dengan jumlah count yang terjadi.

![image](https://github.com/user-attachments/assets/30674467-06b2-4349-adf9-be4ab652ee60)


### c. Pembaca yang Memberi Rating Tertinggi
Mencari orang yang memberi rating paling tinggi pada buku yang dibacanya.
Diketahui rating diberikan pada column G/7.
```
awk -F, '{if ($7 > max && $7 >= 0 && $7 <= 10) {max = $7; name = $2; book = $3}} END {print "Pembaca dengan rating tertinggi:", name, "-", book, "-", max}' reading_data.csv
```
- ```$7 > max && $7 >= 0 && $7 <= 10``` memeriksa apakah pada column 7 yang sebelumnya disimpan memiliki nilai lebih besar dari yang sebelumnya telah disimpan kemudian memberi limit untuk mencari angka pada column 7 yaitu minimal 0 dan maksimal 10.
- ```max = $7; name = $2; book = $3``` untuk menyinpan apabila telah ditemukan rating paling tinggi pada column 7.

![image](https://github.com/user-attachments/assets/30674467-06b2-4349-adf9-be4ab652ee60)


### d. Genre Buku Paling Popular di Asia
Mencari buku yang paling popolar di Asia dan setelah tahun 2023.
```
awk -F, '$9 ~ /Asia/ && $5 > "2023-12-31" {genre[$4]++} 
END {
 max_count = 0;
 for (g in genre) {
 if (genre[g] > max_count) {
    max_count = genre[g];
    popular_genre = g;
    }
}
print "Genre paling populer di Asia setelah 2023 adalah", popular_genre, "dengan", max_count, "buku.";}' reading_data.csv
```
- ```$9 ~ /Asia/``` memberi batasan yang dicari pada column 9 hanya "Asia".
- ```$5 > "2023-12-31"``` mencari tanggal baca setelah 31 Desember 2023.
- ```{genre[$4]++}``` menambah jumlah genre setelah 2 syarat sebelumnya memenuhi.
- ```max_count = 0``` set max_count awal adalah 0 untuk ditambah kemudian.
- ```(genre[g] > max_count)``` memeriksa jumlah genre apakah lebih besar dari max_count.
- ```{max_count = genre[g]``` jika ditemukan genre saat ini lebih banyak dari genre sebelumnya maka akan disimpan ke popular genre.
- ```popular_genre = g``` memperbarui hasil sebelumnya kedalam popular genre.

![image](https://github.com/user-attachments/assets/30674467-06b2-4349-adf9-be4ab652ee60)


Masukkan semua code ke poppo_siroyo.sh.
```
nano poppo_siroyo.sh
```
### Revisi
Menghapus ```wget``` dari file poppo_siroyo.sh.

# Soal 2
### e. The Brutality of Glass
Memeriksa CPU Usage
```
echo "$(lscpu | grep -m1 'Model name')"
echo "Core Usage: $(top -bn1 | awk '/Cpu\(s\)/ {print 100 - $8}')%"
echo "Terminal: $(tty)"
```
- ```$(lscpu | grep -m1 'Model name')``` Mengambil Model Name dari CPU yang sedang digunakan.
- ```Core Usage: $(top -bn1 | awk '/Cpu\(s\)/ {print 100 - $8}')%``` Menghitung total penggunaan CPU dalam persen.
- ```echo "Terminal: $(tty)"``` Menampilkan terminal yang sedang digunakan.

![image](https://github.com/user-attachments/assets/22e15cf4-2c0a-46df-83cc-eb6ab62a94b6)


### f. In Grief and Great Delight
Memeriksa RAM Usage
```
fragment_usage=$(awk '/MemTotal/ {total=$2} /MemAvailable/ {avail=$2} END {print (total-avail)*100/total "%"}' /proc/meminfo)
fragment_used=$(awk '/MemTotal/ {total=$2} /MemAvailable/ {avail=$2} END {print (total-avail)/1024 " MB"}' /proc/meminfo)
fragment_tot=$(awk '/MemTotal/ {print $2/1024 " MB"}' /proc/meminfo)
fragment_avail=$(awk '/MemAvailable/ {print $2/1024 " MB"}' /proc/meminfo)

echo "Fragments Usage: $fragment_usage ($fragment_used / $fragment_tot)"
echo "Fragments Available: $fragment_avail"
```
- ```awk '/MemTotal/ {total=$2} /MemAvailable/ {avail=$2} END {print (total-avail)*100/total "%"}' /proc/meminfo``` Mencari ```MemTotal``` kemudian dikurang ```MemAvailable``` dan kedua itu dibagi dengan ```Memtotal``` dan dikali 100 untuk menghitung usage dari Fragments.
- ```awk '/MemTotal/ {total=$2} /MemAvailable/ {avail=$2} END {print (total-avail)/1024 " MB"}' /proc/meminfo``` Menunjukkan RAM yang sedang dipakai dengan cara ```MemTotal``` - ```MemAvailable``` kemudian dibagi 1024 agar tampil dalam format MB.
Dibagi 1024 agar hasilnya dalam MB.
- ```awk '/MemTotal/ {print $2/1024 " MB"}' /proc/meminfo``` Mencari baris ```MemTotal``` dalam ```/proc/meminfo``` Mengambil dari kolom kedua ```($2)``` nilai total RAM dalam KB kemudian dirubah menjadi MB dengan dibagi 1024.
- ```awk '/MemAvailable/ {print $2/1024 " MB"}' /proc/meminfo``` Mengetahui RAM yang tersedia dengan cara mencari ```MemAvailable``` kemudian diubah ke MB dengan dibagi 1024.
- ```echo "Fragments Usage: $fragment_usage ($fragment_used / $fragment_tot)"``` Print hasil dari ```fragment_usage``` kemudian memperlihatkan berapa RAM yang terpakai ```fragment_used``` dari total RAM ```fragment_tot```.
- ```echo "Fragments Available: $fragment_avail"``` Print hasil dari ```fragment_avail``` untuk mengetahui berapa RAM yang tersedia.

![image](https://github.com/user-attachments/assets/b2e65b86-7465-41c6-a815-587be0949689)


# Soal 3 
Untuk merayakan ulang tahun ke 52 album The Dark Side of the Moon, tim PR Pink Floyd mengadakan sebuah lomba dimana peserta diminta untuk membuat sebuah script bertemakan setidaknya 5 dari 10 lagu dalam album tersebut. Sebagai salah satu peserta, kamu memutuskan untuk memilih Speak to Me, On the Run, Time, Money, dan Brain Damage. Saat program ini dijalankan, terminal harus dibersihkan terlebih dahulu agar tidak mengganggu tampilan dari fungsi fungsi yang kamu buat. Program ini dijalankan dengan cara ./dsotm.sh --play=”<Track>” dengan Track sebagai nama nama lagu yang kamu pilih. [Author: Afnaan / honque]

### a. Speak to Me
Untuk lagu ini, kamu memutuskan untuk membuat sebuah fitur yang memanggil API yang baru saja kamu temukan kemarin, https://github.com/annthurium/affirmations untuk menampilkan word of affirmation setiap detik. Diberikan kebebasan artistik, tidak harus sama persis dengan tampilan pada gif, tetapi untuk fungsionalitas, word of affirmation baru harus ditampilkan tiap detik.



```
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
```
- ```clear``` untuk membersihkan tampilan terminal setiap mengeksekusi
- ```while``` digunakan untuk melakukan perulangan untuk tiap baris afirmasi dengan jeda 1 detik (sleep)
- Menggunakan ```curl``` untuk mengambil data API yang berbentuk JSON untuk disimpan pada variabel affirmation
- Melakukan ```for loop``` untuk print out afirmasi dan memberikan efek animasi huruf satu-persatu


### b. On the Run
Selanjutnya, kamu memutuskan untuk membuat sebuah progress bar yang berjalan dengan interval random (setiap progress bertambah dalam interval waktu yang random dengan range 0.1 detik sampai 1 detik). Diberikan kebebasan artistik, tidak harus sama persis dengan tampilan pada gif, tetapi untuk fungsionalitas, progress bar harus memiliki perhitungan persentase, dan panjang dari progress bar tidak berubah ubah (selalu dari ujung kiri terminal ke ujung kanan terminal seperti pada gif)
```
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

        	# Print out progress bar
        	printf "[%-50s] %3d%%\n" "$(printf '▨%.0s' $(seq 1 $progress))" "$progress"

        	((progress+=2))

    	done
}
```
- Inisialisasi variabel ```progres=0```, nantinya variabel ini akan bertambah hingga 100 seiring berjalannya loading bar
- Perulangan ```while``` akan terus berjalan hingga ```progress``` mencapai 100
- Setiap bar mewakili 2 poin, sehingga dalam satu kali perulangan akan dilakukan penambahan 2 pada variabel ```progress``` ---> ```((progress+=2))
- ```sleep``` digunakan untuk memberikan jeda sesuai dengan pengacakan yang dilakukan ```awk``` dari rentang 0.1 hingga 1
- Menggunakan ```tput cuu 1``` dan ```tput el``` untuk memperbarui tampilan di baris yang sama
- Melakukan print out dengan ```printf``` dengan keterangan :
  - ```[%-50s]``` untuk membuat panjang bar adalah 50 karakter
  - ```printf '▨%.0s'``` untuk mencetak bar sebanyak angka dalam seq
  - ```seq 1 $progress``` untuk membuat angka progress dari 1 hingga 100

Revisi 
```
	# Tambahan
	local width=$(tput cols)  
	local max_bar_width=$((width - 10)) 
```
- Memodifikasi fungsi agar dapat membaca panjang terminal, sehingga tampilan progress bar bisa menyeluruh dari kiri hingga kanan terminal
    

### c. Time
Singkat saja, untuk time, kamu memutuskan untuk membuat live clock yang menunjukkan tanggal, jam, menit dan detik. Diberikan kebebasan artistik, tidak harus sama persis dengan tampilan pada gif, tetapi untuk fungsionalitas, jam harus setidaknya menunjukkan tahun, bulan, tanggal, jam, menit, dan detik yang diperbaharui setiap detik.

```
day_or_night() {

	# Jam 06.00 - 17.59 (Pagi) dan jam 18.00 - 06.00 (Malam)
	if [[ $hour_now -ge 6 && $hour_now -lt 18 ]]; then
		echo "   | ☀️ (Day)"
	else
		echo "   | 🌙 (Night)"
	fi
}

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
```
Terdapat 2 fungsi disini, yaitu ```world_time``` dan ```day_or_night```

Fungsi ```world_time``` digunakan untuk perulangan setiap detik dari beberapa aspek seperti nama wilayah, tanggal, tahun, dan jam secara detail
- ```tput cup 0  0``` untuk membuat tampilan yang dinamis
- ```$(TZ='Asia/Jakarta' date '+%d-%m-%Y')``` akan menampilkan tanggal pada zona Asia/Jakarta dengan format DD-MM-YY
- ```$(TZ='Asia/Jakarta' date '+%H:%M:%S')``` akan menampilkan waktu pada zona Asia/Jakarta dengan format HH-MM-sSS

Fungi ```day_or_night``` digunakan untuk memberi tahukan keadaaan pada jam tertentu adalah siang atau malam
- ```hour_now=$((10#$(TZ='Asia/Jakarta' date '+%H')))``` inisialisasi variabel ```hour_now``` dengan mengambil informasi waktu (jam saja) pada wilayah tertentu
- ```
  if [[ $hour_now -ge 6 && $hour_now -lt 18 ]]; then
		echo "   | ☀️ (Day)"
	else
		echo "   | 🌙 (Night)"
	fi
  ```
  Membuat ```if else```dengan syarat, jika nilai pada variabel jam pada interval 6-18 akan memberikan output ```| ☀️ (Day)```. Sebaliknya, jika jam menunjukkan pada rentang selain 6-18, maka akan memberikan output ```| 🌙 (Night)```

### d. Money
Kamu teringat dengan program yang sangat disukai oleh teman mu yang bernama cmatrix. Kamu pun memutuskan untuk membuat program yang mirip, tetapi mengganti isinya dengan simbol mata uang seperti $ € £ ¥ ¢ ₹ ₩ ₿ ₣ dan lain lainnya. Diberikan kebebasan artistik, tidak harus sama persis dengan tampilan pada gif, tetapi untuk fungsionalitas, matrix tersusun oleh simbol mata uang minimal 5 simbol yang berbeda.
```
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
```
- Melakukan dekalrasi ```symbols``` dengan beberapa simbol mata uang
- ```cols``` dan ```lines``` digunakan untuk menentukan berapa banyam simbols yang akan dicetak dalam terminal
- ```while``` untuk melakukan perulangan terus menerus hingga dihentikan oleh user
- Melakukan perulangan dengan ```for loop``` sebanyak kolom
- ```$RANDOM``` digunakan untuk menbuat indeks untuk simbol yg akan disimpan di ```sysmbol```
- Variabel ```color``` akan memberikan warna acak antara kuning ataupun hijau dengan kode :
  - ```\e[1;32m``` untuk warna hijau
  - ```\e[1;33m``` untuk warna kuning
- Untuk ```printf```:
  - ```\e[1;3%dm%s\e[0m``` digunakan untuk mengatur dan mengembalikan warna teks
  - ```$color``` dan ```$symbol``` adalah input dari warna dan simbol yang telah diacak
- ```sleep 0.15``` memberikan jeda 0.15 detik sebelum loop selanjutnya


### e. Brain Damage
Untuk lagu Brain Damage, kamu mendapatkan ide untuk menampilkan proses yang sedang berjalan, seperti task manager tetapi menampilkannya di dalam terminal dan membuat agar task manager tersebut menampilkan data baru setiap detiknya. Diberikan kebebasan artistik, tidak harus sama persis dengan tampilan pada gif, tetapi untuk fungsionalitas, data harus sesuai dengan ps/top dan sejenisnya.

```
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
```
- Perulangan ```while``` untuk melakukan perulangan hingga progream dihentikan
- ```sleep 1``` akan memberikan jeda sebelum perulangan ```while``` dilakukan kembali
- ```ps -eo pid,user,%cpu,%mem,comm``` akan menampilkan proses yang sedang berjalan seperti pid, user, %cpu, %memory, dan comm
- ```--sort=-%cpu``` akan melakukan sorting CPU usage secara descending (terbesar ke terkecil)
- ```head -10``` menampilkan hanya 10 proses tertinggi 
