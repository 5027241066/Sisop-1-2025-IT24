#a
awk -F, '{
        if ($2 == "Chris Hemsworth") {
            count++
        } else {
            count=count
        }
    }
    END {
        print "Chris Hemsworth membaca", count, "buku.";
    }
' reading_data.csv

#b
awk -F, '{if ($8 == "Tablet") {total += $6; count++}} END {print "Rata-rata durasi membaca dengan Tablet adalah", total/count, "menit."}' reading_data.csv

#c
awk -F, '{if ($7 > max && $7 >= 0 && $7 <= 10) {max = $7; name = $2; book = $3}} END {print "Pembaca dengan rating tertinggi:", name, "-", book, "-", max}' reading_data.csv

#d
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
