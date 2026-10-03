// kalkulator.lp 
//Kalkulator sederhana dalam bahasa Loop

fungsi adalahAngka(s) {
    milik n = panjang(s)
    jika n == 0 maka
        kembali salah
    akhir

    milik mulai = 0
    jika karakter(s, 0) == "-" maka
        mulai = 1
    akhir
    jika mulai >= n maka
        kembali salah
    akhir

    milik jumlahDigit = 0
    milik jumlahTitik = 0
    milik i = mulai
    selama i < n {
        milik c = karakter(s, i)
        jika c == "." maka
            jumlahTitik += 1
            jika jumlahTitik > 1 maka
                kembali salah
            akhir
        selain
            jika cariTeks("0123456789", c) < 0 maka
                kembali salah
            akhir
            jumlahDigit += 1
        akhir
        i += 1
    }
    kembali jumlahDigit > 0
}

// Minta angka dari pengguna. Mengembalikan teks angka, atau "" kalau pengguna ingin keluar.
fungsi bacaAngka(pesan) {
    selama benar {
        milik isian = trim(masukan(pesan))
        jika isian == "" maka
            kembali ""
        akhir
        jika adalahAngka(isian) maka
            kembali isian
        akhir
        cetak "  ! '#{isian}' bukan angka yang valid, coba lagi."
    }
}

// Minta operator dari pengguna. Mengembalikan operator, atau "" kalau pengguna ingin keluar.
fungsi bacaOperator() {
    selama benar {
        milik isian = trim(masukan("Operator       : "))
        jika isian == "" maka
            kembali ""
        akhir
        jika panjang(isian) == 1 dan cariTeks("+-*/%^", isian) >= 0 maka
            kembali isian
        akhir
        cetak "  ! Operator tidak dikenal. Pilih salah satu: + - * / % ^"
    }
}

// Mengembalikan pesan error kalau operasinya tidak valid, atau "" kalau aman.
fungsi cekError(a, op, b) {
    jika (op == "/" atau op == "%") dan b == 0 maka
        kembali "Tidak bisa membagi dengan nol."
    akhir
    jika op == "^" dan a == 0 dan b < 0 maka
        kembali "Nol tidak bisa dipangkatkan bilangan negatif."
    akhir
    jika op == "^" dan a < 0 dan lantai(b) != b maka
        kembali "Hasil bukan bilangan real."
    akhir
    kembali ""
}

fungsi hitung(a, op, b) {
    pilih op {
        kasus "+" -> kembali a + b
        kasus "-" -> kembali a - b
        kasus "*" -> kembali a * b
        kasus "/" -> kembali a / b
        kasus "%" -> kembali a % b
        selain -> kembali pangkat(a, b)
    }
}

// Program utama

cetak "=============================="
cetak "      KALKULATOR  LOOP"
cetak "=============================="
cetak "Operator: +  -  *  /  % (sisa bagi)  ^ (pangkat)"
cetak "Enter kosong = keluar"
cetak ""

milik riwayat = []

selama benar {
    milik teksA = bacaAngka("Angka pertama  : ")
    jika teksA == "" maka
        hentikan
    akhir

    milik op = bacaOperator()
    jika op == "" maka
        hentikan
    akhir

    milik teksB = bacaAngka("Angka kedua    : ")
    jika teksB == "" maka
        hentikan
    akhir

    milik a = keDesimal(teksA)
    milik b = keDesimal(teksB)

    milik pesanError = cekError(a, op, b)
    jika pesanError != "" maka
        cetak "  ! #{pesanError}"
    selain
        milik baris = "#{a} #{op} #{b} = #{hitung(a, op, b)}"
        cetak "  => #{baris}"
        riwayat = tambah(riwayat, baris)
    akhir
    cetak ""
}

cetak ""
jika panjang(riwayat) > 0 maka
    cetak "Riwayat perhitungan:"
    milik i = 0
    selama i < panjang(riwayat) {
        cetak "  #{i + 1}. #{riwayat[i]}"
        i += 1
    }
selain
    cetak "Belum ada perhitungan."
akhir
cetak "Sampai jumpa!"
