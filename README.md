
# WRITE UP
## Praktikum [Modul 1](https://github.com/lab-kcks/Modul-Sisop/tree/main/Modul-1)

Mata Kuliah Sistem Operasi

Dosen pengampu : Ir. Muchammad Husni, M.Kom.



## Kelompok Praktikum [IT-30]

- [Fico Simhanandi - 5027231030](https://github.com/PuroFuro)
- [Jody Hezekiah - 5027221050](https://github.com/imnotjs)
- [Nabiel Nizar Anwari - 5027231087](https://github.com/bielnzar)


## [SOAL 1](https://docs.google.com/document/d/140T6O_YsbBcnblkKqQ5lpN1ji_XQzSMEpAkkqHrtTyU/edit)

Cipung dan abe ingin mendirikan sebuah toko bernama “SandBox”, sedangkan kamu adalah manajer penjualan yang ditunjuk oleh Cipung dan Abe untuk melakukan pelaporan penjualan dan strategi penjualan kedepannya yang akan dilakukan.

Setiap tahun Cipung dan Abe akan mengadakan rapat dengan kamu untuk mengetahui laporan dan strategi penjualan dari “SandBox”. Buatlah beberapa kesimpulan dari data penjualan [“Sandbox.csv”](https://drive.google.com/file/d/1cC6MYBI3wRwDgqlFQE1OQUN83JAreId0/view?usp=sharing) untuk diberikan ke cipung dan abe.

#### A. Karena Cipung dan Abe baik hati, mereka ingin memberikan hadiah kepada customer yang telah belanja banyak. Tampilkan nama pembeli dengan total sales paling tinggi


Untuk menyelesaikan soal diatas, jalankan code dibawah ini : 

```bash
#!/bin/bash

# fungsi untuk menampilkan nama pembeli dengan total penjualan tertinggi
tampilkan_top_pembeli() {
    # Mendapatkan nama pembeli dengan total penjualan paling tinggi
    top_sales=$(tail -n +2 Sandbox.csv | awk -F ',' '{print $6 "," $17}' | sort -t ',' -k2 -nr | head -n 1)

    # Memisahkan nama pembeli dan total penjualan
    customer=$(echo $top_sales | cut -d ',' -f1)
    total_sales=$(echo $top_sales | cut -d ',' -f2)

    # Menampilkan hasil
    echo "Nama pembeli dengan total penjualan paling tinggi adalah: $customer dengan total penjualan sebesar $total_sales"
}
```

#### Fungsi untuk Menampilkan Nama Pembeli dengan Total Penjualan Tertinggi

Skrip shell ini memiliki sebuah fungsi bernama `tampilkan_top_pembeli()` yang berfungsi untuk menampilkan nama pembeli dengan total penjualan tertinggi dari data yang terdapat dalam file `Sandbox.csv`.

Untuk Mendapatkan Nama Pembeli dengan Total Penjualan Tertinggi :

1. Baris `#!/bin/bash` menunjukkan bahwa skrip akan dijalankan oleh program Bash, yang merupakan program yang digunakan untuk mengeksekusi perintah-perintah dalam sistem operasi Unix/Linux.

2. Fungsi `tampilkan_top_pembeli()` isi dan penjelasannya sebagai berikut:
  
Untuk mendapatkan nama pembeli dengan total penjualan tertinggi, skrip melakukan operasi berikut pada file `Sandbox.csv`:

``` # Mendapatkan nama pembeli dengan total penjualan paling tinggi
top_sales=$(tail -n +2 Sandbox.csv | awk -F ',' '{print $6 "," $17}' | sort -t ',' -k2 -nr | head -n 1)

```
Baris ini melakukan beberapa operasi pada file Sandbox.csv:

- `tail -n +2 Sandbox.csv` menampilkan semua baris dalam file Sandbox.csv kecuali baris pertama.

- `awk -F ',' '{print $6 "," $17}'` memisahkan setiap baris berdasarkan koma (,) dan mencetak kolom ke-6 (nama pembeli) dan kolom ke-17 (total penjualan) yang dipisahkan dengan koma.

- `sort -t ',' -k2 -nr` mengurutkan hasil dari *awk* berdasarkan kolom ke-2 (total penjualan) secara descending (dari yang terbesar ke terkecil).

- `head -n 1` mengambil baris pertama dari hasil pengurutan, yaitu nama pembeli dengan total penjualan tertinggi.

- Hasilnya disimpan dalam variabel `top_sales`.

3. Untuk memisahkan nama pembeli dan total penjualan menggunakan skrip berikut : 
```
# Memisahkan nama pembeli dan total penjualan
customer=$(echo $top_sales | cut -d ',' -f1)
total_sales=$(echo $top_sales | cut -d ',' -f2)
```
Baris ini memisahkan nilai top_sales menjadi dua variabel:

- `customer` berisi nama pembeli yang diambil dari kolom pertama (sebelum koma).

- `total_sales` berisi total penjualan yang diambil dari kolom kedua (setelah koma).

4. Selanjutnya, Menampilkan hasil dengan config berikut : 
```
# Menampilkan hasil
echo "Nama pembeli dengan total penjualan paling tinggi adalah: $customer dengan total penjualan sebesar $total_sales"
```

Baris terakhir ini menampilkan hasil dari fungsi `tampilkan_top_pembeli` dengan mencetak "Nama pembeli dengan total penjualan paling tinggi adalah: [nama pembeli] dengan total penjualan sebesar [total penjualan]".

Jadi, fungsi `tampilkan_top_pembeli` ini akan mencari nama pembeli dengan total penjualan tertinggi dari data dalam file `Sandbox.csv`, lalu menampilkannya ke layar.




#### B. Karena karena Cipung dan Abe ingin mengefisienkan penjualannya, mereka ingin merencanakan strategi penjualan untuk customer segment yang memiliki profit paling kecil. Tampilkan customer segment yang memiliki profit paling kecil

Untuk menyelesaikan soal diatas, jalankan code dibawah ini : 

```bash
segmentprofit_terendah() {
    # Mendapatkan total profit untuk setiap customer segment
    corporate_profit=$(awk -F ',' '$7 == "Corporate" { sum += $20 } END { printf "%.2f", sum }' Sandbox.csv)
    homeoffice_profit=$(awk -F ',' '$7 == "Home Office" { sum += $20 } END { printf "%.2f", sum }' Sandbox.csv)
    consumer_profit=$(awk -F ',' '$7 == "Consumer" { sum += $20 } END { printf "%.2f", sum }' Sandbox.csv)

    # Menampilkan total profit untuk setiap customer segment
    echo "Total profit untuk Corporate segment: $corporate_profit"
    echo "Total profit untuk Home Office segment: $homeoffice_profit"
    echo "Total profit untuk Consumer segment: $consumer_profit"

    # Mencari profit paling rendah di antara ketiga customer segment

    profit_terendah=$(echo -e "$corporate_profit\n $homeoffice_profit\n $consumer_profit" | sort -n | head -n 1)

    # Menampilkan hasil
    if [ "$(bc <<<"$profit_terendah == $corporate_profit")" -eq 1 ]; then
        echo "Segment dengan profit paling rendah adalah Corporate dengan total profit sebesar $profit_terendah"
    elif [ "$(bc <<<"$profit_terendah == $homeoffice_profit")" -eq 1 ]; then
        echo "Segment dengan profit paling rendah adalah Home Office dengan total profit sebesar $profit_terendah"
    else
        echo "Segment dengan profit paling rendah adalah Consumer dengan total profit sebesar $profit_terendah"
    fi
}
```
### Berikut adalah penjelasan untuk skrip shell yang diberikan :

1. Fungsi ini menggunakan perintah awk untuk menghitung total profit untuk setiap customer segment :

- `awk -F ',' '$7 == "Corporate" { sum += $20 } END { printf "%.2f", sum }' Sandbox.csv` menghitung total profit untuk customer segment "Corporate" dengan menjumlahkan kolom ke-20 (profit) dari baris-baris yang memiliki nilai "Corporate" pada kolom ke-7 (segment). Hasil diformat menjadi dua angka desimal dan disimpan dalam variabel `corporate_profit`.
- `homeoffice_profit` dan `consumer_profit` dihitung dengan cara yang sama untuk customer segment "Home Office" dan "Consumer".

2. Menampilkan Total Profit untuk Setiap Customer Segment
```
echo "Total profit untuk Corporate segment: $corporate_profit"
echo "Total profit untuk Home Office segment: $homeoffice_profit"
echo "Total profit untuk Consumer segment: $consumer_profit"
```
Kemudian, fungsi menampilkan total profit untuk setiap customer segment menggunakan perintah echo.

3. Mencari Profit Paling Rendah di Antara Ketiga Customer Segment
```
profit_terendah=$(echo -e "$corporate_profit\n $homeoffice_profit\n $consumer_profit" | sort -n | head -n 1)
```
Fungsi menggabungkan nilai `corporate_profit`, `homeoffice_profit`, dan `consumer_profit` menjadi satu string dengan dipisahkan oleh baris baru (\n). Kemudian, string tersebut diurutkan secara ascending (dari yang terkecil ke yang terbesar) menggunakan perintah `sort -n`. Nilai terkecil (profit terendah) diambil menggunakan perintah `head -n 1` dan disimpan dalam variabel `profit_terendah`.

4. Menampilkan Hasil
```
if [ "$(bc <<<"$profit_terendah == $corporate_profit")" -eq 1 ]; then
    echo "Segment dengan profit paling rendah adalah Corporate dengan total profit sebesar $profit_terendah"
elif [ "$(bc <<<"$profit_terendah == $homeoffice_profit")" -eq 1 ]; then
    echo "Segment dengan profit paling rendah adalah Home Office dengan total profit sebesar $profit_terendah"
else
    echo "Segment dengan profit paling rendah adalah Consumer dengan total profit sebesar $profit_terendah"
fi
```
Selanjutnya, fungsi menampilkan customer segment dengan profit terendah beserta nilai profitnya menggunakan pernyataan kondisional i`f...elif...else`. Perbandingan nilai `profit_terendah` dengan nilai `corporate_profit`, `homeoffice_profit`, dan `consumer_profit` dilakukan menggunakan perintah `bc`. yang digunakan untuk membandingkan dua nilai numerik.

Dalam contoh di atas, `-eq 1` digunakan untuk memeriksa apakah hasil evaluasi dari `bc` sama dengan 1. Jika benar (true, atau sama dengan 1), maka blok kode di dalam if akan dieksekusi.

Jadi, fungsi `segmentprofit_terendah` ini akan mencari customer segment dengan total profit terendah dari data dalam file `Sandbox.csv`, lalu menampilkannya ke layar.


#### C. Cipung dan Abe hanya akan membeli stok barang yang menghasilkan profit paling tinggi agar efisien. Tampilkan 3 category yang memiliki total profit paling tinggi 
```
kategoriprofit_tertinggi() {
    # Mendapatkan total profit untuk setiap category
    technology_profit=$(awk -F ',' '$14 == "Technology" { sum += $20 } END { printf "%.2f", sum }' Sandbox.csv)
    furniture_profit=$(awk -F ',' '$14 == "Furniture" { sum += $20 } END { printf "%.2f", sum }' Sandbox.csv)
    officesupplies_profit=$(awk -F ',' '$14 == "Office Supplies" { sum += $20 } END { printf "%.2f", sum }' Sandbox.csv)

    # Menggabungkan profit dan nama kategori dalam satu string dengan tab sebagai pemisah
    profit=$(echo -e "$technology_profit\t Technology\n $furniture_profit\t Furniture\n $officesupplies_profit\t Office Supplies")

    # Mengurutkan total profit dari yang paling tinggi
    profit=$(echo "$profit" | sort -nr)

    # Menampilkan hasil
    echo "Total profit untuk kategori Technology: $technology_profit"
    echo "Total profit untuk kategori Furniture: $furniture_profit"
    echo "Total profit untuk kategori Office Supplies: $officesupplies_profit"

    echo "Top 3 categories dengan total profit paling tinggi adalah:"
    echo "$profit" | head -n 3 | awk -F '\t' '{print $2}'
}
```

1. Untuk mendapatkan total profit dari setiap kategori

Fungsi ini menggunakan perintah awk untuk menghitung total profit untuk setiap kategori:

- `awk -F ',' '$14 == "Technology" { sum += $20 } END { printf "%.2f", sum }' Sandbox.csv` menghitung total profit untuk kategori "Technology" dengan menjumlahkan kolom ke-20 (profit) dari baris-baris yang memiliki nilai "Technology" pada kolom ke-14 (category). Hasil diformat menjadi dua angka desimal dan disimpan dalam variabel `technology_profit`.

- `furniture_profit` dan `officesupplies_profit` dihitung dengan cara yang sama untuk kategori "Furniture" dan "Office Supplies".

2. Menggabungkan Profit dan Nama Kategori
```
profit=$(echo -e "$technology_profit\t Technology\n $furniture_profit\t Furniture\n $officesupplies_profit\t Office Supplies")
```
Fungsi menggabungkan nilai `technology_profit`, `furniture_profit`, dan `officesupplies_profit` dengan nama kategori masing-masing dalam satu string yang dipisahkan oleh tab (`\t`) dan baris baru (`\n`).

3. Mengurutkan total profit dari yang paling tinggi
```
profit=$(echo "$profit" | sort -nr)
```
Kemudian, string yang berisi profit dan nama kategori diurutkan secara descending (dari yang terbesar ke yang terkecil) menggunakan perintah `sort -nr`.

4. Menampilkan hasil

Fungsi menampilkan total profit untuk setiap kategori menggunakan perintah `echo`. Selanjutnya, fungsi menampilkan "Top 3 categories dengan total profit paling tinggi adalah : " diikuti dengan nama tiga kategori dengan profit tertinggi yang diperoleh dari mengambil tiga baris pertama `head -n 3` dari string `profit` yang telah diurutkan, kemudian mencetak kolom kedua `awk -F '\t' '{print $2}'` yang berisi nama kategori.

Kesimpulan
Jadi, fungsi `kategoriprofit_tertinggi` ini akan mencari tiga kategori dengan total profit tertinggi dari data dalam file Sandbox.csv, lalu menampilkannya ke layar.
#### D. Karena ada seseorang yang lapor kepada Cipung dan Abe bahwa pesanannya tidak kunjung sampai, maka mereka ingin mengecek apakah pesanan itu ada. Cari purchase date dan amount (quantity) dari nama adriaens
```
mencaripesanan_adriaens() {
    # Mencari purchase date dan amount (quantity) dari pelanggan dengan nama "adriaens" berdasarkan firstname saja
    pesanan=$(awk -F ',' '{split(tolower($6), a, " "); for(i in a) if(a[i] == "adriaens") print $2 "," $18}' Sandbox.csv)

    # Menampilkan hasil
    if [ -z "$pesanan" ]; then
        echo "Pesanan untuk pelanggan dengan nama adriaens tidak ditemukan."
    else
        echo "Purchase date dan amount (quantity) untuk pelanggan dengan nama adriaens adalah:"
        echo "$pesanan"
    fi
}
```
Fungsi shell script `mencaripesanan_adriaens` ini dirancang untuk mencari dan menampilkan tanggal pembelian (purchase date) dan jumlah (quantity) barang yang dibeli oleh pelanggan dengan nama depan "adriaens" dari sebuah file CSV. Mari kita bahas setiap bagian dari skrip ini untuk memahami cara kerjanya:

1. Mencari Data dengan `awk`:
```
pesanan=$(awk -F ',' '{split(tolower($6), a, " "); for(i in a) if(a[i] == "adriaens") print $2 "," $18}' Sandbox.csv)
```
- `awk -F ','` menggunakan awk dengan field separator (pemisah kolom) berupa koma (`,`), mengindikasikan bahwa file CSV dipisahkan oleh koma.
~ `{split(tolower($6), a, " "); for(i in a) if(a[i] == "adriaens") print $2 "," $18}` merupakan blok kode awk yang melakukan hal berikut:

- `split(tolower($6), a, " ")`: Memecah nilai dari kolom ke-6 menjadi array a berdasarkan spasi. Fungsi `tolower` digunakan untuk mengubah teks menjadi huruf kecil agar pencarian menjadi case-insensitive.
- `for(i in a) if(a[i] == "adriaens")`: Melakukan iterasi pada array a dan mencari jika ada elemen yang sama dengan "adriaens".
- `print $2 "," $18` : Jika kondisi terpenuhi, maka mencetak nilai dari kolom ke-2 (tanggal pembelian) dan kolom ke-18 (jumlah/quantity), dipisahkan oleh koma.

- Hasil pencarian disimpan dalam variabel `pesanan`.

2. Menampilkan hasil:
- Bagian ini memeriksa apakah variabel `pesanan` kosong atau tidak. Jika kosong, berarti tidak ada pesanan yang ditemukan untuk pelanggan dengan nama "adriaens".
```
if [ -z "$pesanan" ]; then
    echo "Pesanan untuk pelanggan dengan nama adriaens tidak ditemukan."
else
    echo "Purchase date dan amount (quantity) untuk pelanggan dengan nama adriaens adalah:"
    echo "$pesanan"
fi
```
- `[ -z "$pesanan" ]`: Memeriksa apakah string `pesanan` kosong.
    -z: Operator ini digunakan untuk memeriksa "string length is zero". Jika string yang diperiksa memang kosong, kondisi ini bernilai true.

- Jika kosong, mencetak pesan bahwa tidak ada pesanan yang ditemukan.
- Jika tidak kosong, mencetak tanggal pembelian dan jumlah barang yang dibeli oleh pelanggan dengan nama "adriaens".





#### Untuk menampilkan semua hasil yang telah di proses

```
main() {

    while true; do
        clear
        # Pilihan user untuk menjalankan fungsi yang diinginkan
        echo
        echo "Pilih fungsi yang ingin dijalankan:"
        echo "a) Tampilkan nama pembeli dengan total penjualan paling tinggi"
        echo "b) Cari customer segment dengan profit paling rendah"
        echo "c) Tampilkan 3 kategori dengan total profit paling tinggi"
        echo "d) Cari purchase date dan amount (quantity) dari pelanggan dengan nama 'adriaens'"
        read -p "Masukkan pilihan (a/b/c/d): " pilihan
        echo

        case $pilihan in
        a)
            tampilkan_top_pembeli
            echo
            read -p "Tekan Enter untuk melanjutkan..."
            ;;
        b)
            segmentprofit_terendah
            echo
            read -p "Tekan Enter untuk melanjutkan..."
            ;;
        c)
            kategoriprofit_tertinggi
            echo
            read -p "Tekan Enter untuk melanjutkan..."
            ;;
        d)
            mencaripesanan_adriaens
            echo
            read -p "Tekan Enter untuk melanjutkan..."
            ;;
        *) echo "Pilihan tidak valid." && break ;;
        esac

        clear
    done
}

main
```
