# Aplikasi Biodata Diri

Tugas Praktik Pemrograman Flutter — aplikasi sederhana yang menampilkan foto diri,
nama lengkap, NIM, kelas, serta tempat dan tanggal lahir.

## Cara menjalankan

```bash
flutter pub get
flutter run
```

> Materi penjelasan widget dan naskah video presentasi tersedia di
> [`PENJELASAN_DAN_SCRIPT.md`](PENJELASAN_DAN_SCRIPT.md).


## Cara mengubah data

1. Buka `lib/main.dart`.
2. Ubah nilai konstanta di bagian **UBAH DATA BIODATA DI BAWAH INI**:


3. Ganti file `assets/foto.jpg` dengan foto diri Anda (nama file harus tetap
   `foto.jpg`, atau sesuaikan `fotoPath` bila memakai nama lain).
4. Simpan, lalu jalankan ulang aplikasi (hot restart).

## Fitur tampilan

- Header gradien dengan foto profil berbentuk lingkaran.
- Chip NIM dan kelas di bawah nama.
- Kartu informasi pribadi dengan ikon untuk setiap data.
- Fallback ikon otomatis jika foto belum tersedia.
