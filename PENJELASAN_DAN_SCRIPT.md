# Penjelasan Widget & Naskah Video — Aplikasi Biodata Diri

Dokumen ini berisi:
1. Gambaran alur aplikasi.
2. Penjelasan fungsi dan penggunaan setiap widget yang dipakai di `lib/main.dart`.
3. Naskah video demonstrasi maksimal 5 menit.
4. Prediksi pertanyaan dosen dan jawabannya.

---

## 1. Gambaran Aplikasi

Aplikasi menampilkan satu halaman biodata berisi foto, nama, NIM, kelas, dan tempat/tanggal lahir. Data disimpan sebagai `const` di bagian atas `main.dart`, sehingga mudah diubah tanpa menyentuh bagian tampilan.

Alur pemanggilan widget:

```text
main()
└── runApp()
    └── BiodataApp (StatelessWidget)
        └── MaterialApp
            └── BiodataPage (StatelessWidget)
                └── Scaffold
                    └── SingleChildScrollView
                        └── Column
                            ├── _buildHeader()
                            │   └── Container (gradien)
                            │       └── SafeArea
                            │           └── Padding
                            │               └── Column
                            │                   ├── Text "BIODATA DIRI"
                            │                   ├── SizedBox
                            │                   ├── Container (bingkai foto)
                            │                   │   └── ClipOval
                            │                   │       └── Image.asset
                            │                   ├── SizedBox
                            │                   ├── Text (nama)
                            │                   ├── SizedBox
                            │                   └── Wrap
                            │                       ├── _HeaderChip (NIM)
                            │                       └── _HeaderChip (kelas)
                            └── Padding
                                └── Column
                                    ├── Text "Informasi Pribadi"
                                    ├── SizedBox
                                    ├── Container (kartu)
                                    │   └── Column
                                    │       ├── _InfoTile (nama)
                                    │       ├── _TileDivider
                                    │       ├── _InfoTile (NIM)
                                    │       ├── _TileDivider
                                    │       ├── _InfoTile (kelas)
                                    │       ├── _TileDivider
                                    │       └── _InfoTile (TTL)
                                    ├── SizedBox
                                    └── Center
                                        └── Text (footer)
```

---

## 2. Penjelasan Setiap Widget

### 2.1 Entry Point dan Widget Root

#### `main()` dan `runApp()`

```dart
void main() {
  runApp(const BiodataApp());
}
```

- `main()` adalah titik awal program Dart.
- `runApp()` menempelkan widget ke layar dan memulai proses rendering Flutter.
- `BiodataApp` dibungkus `const` karena objeknya tidak berubah.

#### `StatelessWidget`

Dipakai oleh `BiodataApp`, `BiodataPage`, `_HeaderChip`, `_InfoTile`, dan `_TileDivider`.

- Widget yang tidak memiliki state/status yang berubah selama aplikasi berjalan.
- Wajib meng-override method `build(BuildContext context)` yang mengembalikan widget UI.
- Cocok karena biodata bersifat statis (tidak ada tombol yang mengubah data).

Contoh:

```dart
class BiodataPage extends StatelessWidget {
  const BiodataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(...);
  }
}
```

- `super.key` meneruskan key ke parent untuk identifikasi widget.
- `BuildContext` adalah posisi widget di dalam widget tree. Dipakai untuk mengakses tema, ukuran layar, navigasi, dan lain-lain.

#### `MaterialApp`

```dart
MaterialApp(
  title: 'Biodata Diri',
  debugShowCheckedModeBanner: false,
  theme: ThemeData(...),
  home: const BiodataPage(),
)
```

Fungsi:
- Widget root yang menyediakan fondasi Material Design.
- Mengatur judul aplikasi (`title`).
- Menyediakan tema global (`theme`).
- Menentukan halaman pertama (`home`).
- `debugShowCheckedModeBanner: false` menghilangkan pita "DEBUG" di pojok layar.

#### `ThemeData` dan `ColorScheme.fromSeed`

```dart
theme: ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: _primary,
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: const Color(0xFFF4F6FB),
),
```

- `ThemeData` mengatur gaya aplikasi secara menyeluruh (warna, font, komponen).
- `useMaterial3: true` mengaktifkan tampilan Material 3.
- `ColorScheme.fromSeed` membuat palet warna harmonis dari satu warna dasar (`_primary` = biru).
- `brightness: Brightness.light` memilih mode terang.
- `scaffoldBackgroundColor` mengatur warna latar halaman.

#### `Scaffold`

```dart
Scaffold(
  body: SingleChildScrollView(...),
)
```

- Kerangka dasar sebuah halaman Material.
- Menyediakan slot `appBar`, `body`, `floatingActionButton`, `drawer`, dan lain-lain.
- Di aplikasi ini hanya `body` yang dipakai karena header dibuat sendiri.

#### `SafeArea`

```dart
SafeArea(
  bottom: false,
  child: Padding(...),
)
```

- Menjaga konten agar tidak tertutup notch, kamera depan, atau status bar.
- `bottom: false` berarti padding aman di bagian bawah tidak ditambahkan, sehingga gradien header tetap penuh.
- Diletakkan di dalam header agar teks dan foto tidak menabrak status bar.

---

### 2.2 Widget Layout

#### `SingleChildScrollView`

```dart
SingleChildScrollView(
  padding: const EdgeInsets.only(bottom: 32),
  child: Column(...),
)
```

- Membuat isi halaman bisa digulir (scroll) bila tingginya melebihi layar.
- Mencegah error overflow pada layar kecil.
- `padding` memberi ruang kosong 32 px di bagian bawah.

#### `Column`

- Menyusun anak-anaknya secara **vertikal**.
- `crossAxisAlignment: CrossAxisAlignment.start` membuat isi rata kiri.
- Tanpa properti tersebut, default-nya `center` (seperti pada header).
- Dipakai untuk menyusun header, isi kartu, dan susunan label/nilai.

#### `Row`

- Menyusun anak secara **horizontal**.
- Dipakai di `_InfoTile` (ikon + teks) dan `_HeaderChip` (ikon + teks).
- `mainAxisSize: MainAxisSize.min` membuat lebar Row mengikuti isi, bukan memenuhi layar.

#### `Expanded`

```dart
Expanded(
  child: Column(...),
)
```

- Mengambil sisa ruang horizontal di dalam `Row`.
- Penting agar teks panjang (misalnya "Tempat, Tanggal Lahir") membungkus ke baris baru, bukan menyebabkan overflow.
- Hanya boleh dipakai di dalam `Row`, `Column`, atau `Flex`.

#### `Padding`

- Memberi jarak di dalam widget terhadap anaknya.
- Varian yang dipakai:
  - `EdgeInsets.only(bottom: 32)` → hanya bawah.
  - `EdgeInsets.fromLTRB(20, 28, 20, 0)` → kiri, atas, kanan, bawah.
  - `EdgeInsets.symmetric(horizontal: 18, vertical: 16)` → kiri-kanan dan atas-bawah.

#### `SizedBox`

- Kotak kosong berukuran tetap; di sini dipakai sebagai **jarak** antar widget.
- Contoh: `SizedBox(height: 14)`, `SizedBox(width: 6)`.
- Bisa juga dipakai untuk memaksa ukuran anak.

#### `Center`

```dart
Center(
  child: Text('Dibuat dengan Flutter', ...),
)
```

- Menempatkan anak di tengah secara horizontal dan vertikal.
- Di sini dipakai untuk memusatkan teks footer.

#### `Wrap`

```dart
Wrap(
  alignment: WrapAlignment.center,
  spacing: 8,
  runSpacing: 8,
  children: [...],
)
```

- Seperti `Row`, tetapi otomatis pindah ke baris baru jika ruang tidak cukup.
- `spacing` = jarak horizontal antar chip.
- `runSpacing` = jarak vertikal antar baris.
- Cocok untuk chip NIM dan kelas pada layar sempit.

#### `Divider`

```dart
Divider(
  height: 1,
  thickness: 1,
  indent: 78,
  endIndent: 18,
  color: Color(0xFFEEF2F7),
)
```

- Garis pemisah horizontal.
- `indent` = jarak dari kiri (78 px agar sejajar setelah ikon).
- `endIndent` = jarak dari kanan.
- `height` = tinggi area divider; `thickness` = ketebalan garis.

---

### 2.3 Widget Tampilan

#### `Container`

- Kotak serbaguna: bisa punya ukuran, padding, margin, dekorasi, dan anak.
- Dipakai untuk:
  1. Header bergradien.
  2. Bingkai foto bulat.
  3. Kartu informasi putih.
  4. Kotak latar ikon.
  5. Chip NIM/kelas.
- Secara internal `Container` menggabungkan `DecoratedBox`, `Padding`, `Align`, dan `ConstrainedBox`.

#### `Text`

- Menampilkan teks.
- Properti yang dipakai:
  - `textAlign: TextAlign.center` → teks rata tengah.
  - `style: TextStyle(...)` → ukuran, warna, ketebalan, jarak huruf, tinggi baris.
- Dipakai untuk judul, nama, label, nilai data, dan footer.

#### `TextStyle`

- Mengatur tampilan teks:
  - `fontSize` → ukuran huruf.
  - `fontWeight: FontWeight.w700` → tebal.
  - `color` → warna.
  - `letterSpacing: 4` → jarak antar huruf pada judul "BIODATA DIRI".
  - `height: 1.3` → jarak antarbaris.

#### `Icon` dan `IconData`

```dart
Icon(Icons.person_outline_rounded, color: _primary, size: 24)
```

- `Icon` menampilkan ikon dari font Material.
- `Icons.*` menghasilkan nilai bertipe `IconData`.
- Ikon yang dipakai: person, badge, school, cake, dan person_rounded untuk fallback foto.
- Ikon membuat informasi lebih mudah dikenali secara visual.

#### `Image.asset`

```dart
Image.asset(
  fotoPath,
  fit: BoxFit.cover,
  errorBuilder: (context, error, stackTrace) { ... },
)
```

- Memuat gambar dari folder `assets` yang sudah didaftarkan di `pubspec.yaml`.
- `fit: BoxFit.cover` membuat gambar memenuhi kotak dan dipotong proporsional tanpa gepeng.
- `errorBuilder` menampilkan ikon pengganti jika file gagal dimuat, sehingga aplikasi tidak crash.

Pendaftaran aset:

```yaml
flutter:
  assets:
    - assets/foto.jpg
```

#### `ClipOval`

```dart
ClipOval(
  child: Image.asset(...),
)
```

- Memotong anaknya menjadi bentuk oval/lingkaran.
- Dipakai agar foto persegi tampil bulat mengikuti bingkai.

#### `BoxDecoration`

- Mengatur dekorasi sebuah `Container`:
  - `color` → warna latar.
  - `gradient` → gradasi warna.
  - `borderRadius` → sudut melengkung.
  - `boxShadow` → bayangan.
  - `border` → garis tepi.
  - `shape: BoxShape.circle` → bentuk lingkaran.
- Tidak bisa dipakai bersamaan dengan `color` dan `gradient` pada properti yang sama; di sini dipilih salah satu.

#### `LinearGradient`

```dart
LinearGradient(
  colors: [Color(0xFF2563EB), Color(0xFF7C3AED)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
)
```

- Membuat gradasi linear dari biru ke ungu.
- `begin` dan `end` menentukan arah gradasi.

#### `BorderRadius`, `Radius`, dan `Border`

- `BorderRadius.circular(24)` → semua sudut melengkung 24 px.
- `BorderRadius.vertical(bottom: Radius.circular(36))` → hanya sudut bawah yang melengkung.
- `Border.all(color: Colors.white, width: 4)` → garis tepi putih setebal 4 px pada bingkai foto/chip.

#### `BoxShadow` dan `Offset`

- `BoxShadow` memberi efek bayangan pada container.
- `blurRadius` mengatur kelembutan bayangan.
- `offset: Offset(0, 10)` menggeser bayangan 10 px ke bawah.
- `Colors.black.withValues(alpha: 0.05)` membuat hitam transparan 5%.

#### `Color` dan `Colors`

- `Color(0xFF2563EB)` membuat warna dari kode heksadesimal ARGB.
- `Colors.white`, `Colors.black`, `Colors.white70` adalah warna bawaan Material.
- `withValues(alpha: ...)` membuat variasi transparansi dari warna tersebut.

#### `EdgeInsets`

- Bukan widget, melainkan objek untuk mengatur padding/margin.
- `EdgeInsets.only`, `EdgeInsets.fromLTRB`, dan `EdgeInsets.symmetric` dipakai sesuai kebutuhan.

#### `Alignment` dan `BoxFit`

- `Alignment.topLeft`, `Alignment.bottomRight` menentukan arah gradasi.
- `BoxFit.cover` menentukan cara gambar menyesuaikan kotak.

---

### 2.4 Custom Widget (Widget Buatan Sendiri)

#### `_InfoTile`

```dart
_InfoTile(
  icon: Icons.badge_outlined,
  label: 'Nomor Induk Mahasiswa',
  value: nim,
)
```

- Widget buatan sendiri untuk satu baris informasi.
- Menerima tiga parameter: `icon`, `label`, dan `value`.
- Dibuat sekali, dipakai empat kali (nama, NIM, kelas, TTL).
- Tujuannya menghindari duplikasi kode dan menjaga tampilan konsisten.
- Susunannya: `Padding` → `Row` → [`Container` berisi `Icon`, `SizedBox`, `Expanded` → `Column` (label + nilai)].

#### `_HeaderChip`

- Widget pil kecil untuk menampilkan NIM dan kelas di header.
- Parameter: `icon` dan `text`.
- Susunannya: `Container` → `Row` → `Icon` + `Text`.
- Dibuat dua kali dengan isi berbeda, sehingga kode lebih rapi.

#### `_TileDivider`

- Pembungkus `Divider` dengan pengaturan indentasi yang sama.
- Menghindari penulisan properti divider berulang kali.

#### Awalan `_` pada nama class

- Di Dart, nama yang diawali garis bawah bersifat **private** terhadap library/file.
- Artinya `_InfoTile`, `_HeaderChip`, dan `_TileDivider` hanya dipakai di `main.dart`.

---

### 2.5 Konsep Pendukung yang Perlu Dijelaskan

| Konsep | Penjelasan Singkat |
| --- | --- |
| `const` | Nilai/objek yang sudah pasti saat compile-time; menghemat rebuild. |
| Named parameter | Parameter ditulis dengan nama, misalnya `height: 14`, sehingga kode lebih jelas. |
| Widget tree | Susunan widget induk-anak yang membentuk tampilan. |
| Composition | Membangun UI kompleks dari widget-widget kecil, bukan inheritance. |
| `BuildContext` | Posisi widget dalam widget tree; dipakai untuk tema dan navigasi. |
| Hot reload | Perubahan kode langsung terlihat tanpa menutup aplikasi. |
| `pubspec.yaml` | Tempat mendaftarkan dependency dan aset seperti `assets/foto.jpg`. |

---

## 3. Naskah Video Demonstrasi (Maksimal 5 Menit)

> Tips: rekam dengan resolusi 1080p, tampilkan source code di kiri dan aplikasi/emulator di kanan bila memungkinkan. Gerakkan kursor ke widget yang sedang dibahas.

### 0:00–0:25 — Pembukaan

"Halo, nama saya Muhamad Ilyas, NIM 24090045, kelas 5B. Pada video ini saya akan mendemonstrasikan aplikasi Flutter bertema Halaman Biodata Diri. Aplikasi ini menampilkan foto diri, nama lengkap, NIM, kelas, serta tempat dan tanggal lahir. Saya juga akan menjelaskan source code dan fungsi widget yang digunakan."

### 0:25–0:55 — Demonstrasi Aplikasi

"Sekarang saya jalankan aplikasinya. Halaman ini memiliki header bergradien biru ke ungu, foto profil bulat, nama saya, serta chip NIM dan kelas. Di bawahnya ada kartu Informasi Pribadi yang berisi nama lengkap, NIM, kelas, dan tempat tanggal lahir. Halaman dapat digulir agar aman di layar kecil."

### 0:55–1:30 — Struktur Utama

"Struktur aplikasi dimulai dari fungsi `main` yang memanggil `runApp` dengan `BiodataApp`. `BiodataApp` adalah `StatelessWidget` yang mengembalikan `MaterialApp`. Di sini saya mengatur judul aplikasi, tema Material 3, warna dasar biru melalui `ColorScheme.fromSeed`, dan halaman pertama melalui properti `home`, yaitu `BiodataPage`."

### 1:30–2:20 — Header dan Foto

"`BiodataPage` mengembalikan `Scaffold` sebagai kerangka halaman. Bagian body diisi `SingleChildScrollView` agar konten bisa digulir, lalu `Column` untuk menyusun header dan kartu secara vertikal. Header adalah `Container` dengan `BoxDecoration` berisi `LinearGradient` dan sudut bawah melengkung. Di dalamnya saya letakkan `SafeArea` agar konten tidak tertutup status bar, lalu `Padding` dan `Column`. Foto menggunakan `Image.asset` dengan `BoxFit.cover` agar tidak gepeng, dibungkus `ClipOval` agar berbentuk lingkaran. Saya juga menambahkan `errorBuilder` supaya jika foto gagal dimuat, muncul ikon pengganti. Nama ditampilkan dengan `Text`, sedangkan NIM dan kelas memakai `Wrap` berisi custom widget `_HeaderChip`."

### 2:20–3:05 — Kartu Informasi

"Bagian bawah berisi teks 'Informasi Pribadi' dan sebuah `Container` putih dengan `borderRadius` serta `BoxShadow` sebagai kartu. Di dalamnya ada `Column` berisi empat `_InfoTile`. `_InfoTile` adalah widget buatan saya yang menerima parameter ikon, label, dan value. Susunannya `Padding`, `Row`, `Container` untuk latar ikon, `Icon`, lalu `Expanded` berisi `Column` dengan `Text` label dan nilai. `Expanded` penting agar teks panjang membungkus dan tidak overflow. Antar item dipisahkan `_TileDivider` yang membungkus widget `Divider`."

### 3:05–3:50 — Data, Aset, dan Reusability

"Data biodata saya simpan sebagai konstanta di bagian atas file, seperti `namaLengkap`, `nim`, `kelas`, dan `tempatTanggalLahir`, sehingga mudah diubah tanpa menyentuh layout. Foto diletakkan di folder `assets` dan didaftarkan pada `pubspec.yaml` bagian `flutter: assets:`. Saya memakai custom widget `_HeaderChip`, `_InfoTile`, dan `_TileDivider` agar kode tidak berulang. Karena data tidak berubah, seluruh halaman cukup menggunakan `StatelessWidget`."

### 3:50–4:30 — Demonstrasi Akhir dan Pengujian

"Saya jalankan `flutter analyze` dan `flutter test`. Hasilnya tidak ada issue dan seluruh test lulus. Test memastikan judul, nama, NIM, kelas, serta tempat tanggal lahir benar-benar tampil. Saya juga menggulir halaman untuk memastikan tidak ada overflow. Jika data ingin diganti, cukup ubah konstanta dan ganti file `assets/foto.jpg`."

### 4:30–4:55 — Penutup

"Kesimpulannya, aplikasi ini dibangun dari widget dasar seperti `Scaffold`, `Column`, `Row`, `Container`, `Text`, `Image`, dan `Wrap`, lalu dikombinasikan dengan custom widget agar rapi dan dapat digunakan ulang. Sekian demonstrasi dari saya. Terima kasih."

---

## 4. Prediksi Pertanyaan Dosen dan Jawaban

**1. Mengapa memakai `StatelessWidget`, bukan `StatefulWidget`?**
Karena data biodata statis dan tidak berubah selama aplikasi berjalan. `StatefulWidget` baru diperlukan jika ada interaksi yang mengubah tampilan, misalnya form edit biodata dengan `setState`.

**2. Apa fungsi `runApp`?**
Menempelkan widget root ke layar dan menjalankan aplikasi Flutter.

**3. Apa perbedaan `Container` dan `SizedBox`?**
`SizedBox` hanya mengatur ukuran/jarak. `Container` lebih lengkap karena bisa menampung padding, margin, dekorasi, dan anak.

**4. Mengapa `Expanded` diperlukan?**
Agar kolom teks mengambil sisa ruang di dalam `Row`. Tanpa `Expanded`, teks panjang bisa menyebabkan overflow.

**5. Mengapa memakai `SingleChildScrollView`?**
Karena konten satu halaman bisa lebih tinggi dari layar. Widget ini membuatnya dapat digulir dan mencegah overflow.

**6. Apa fungsi `ClipOval`?**
Memotong gambar persegi menjadi bentuk lingkaran agar sesuai bingkai foto profil.

**7. Apa arti `BoxFit.cover`?**
Gambar diperbesar hingga memenuhi kotak, lalu bagian berlebih dipotong, sehingga rasio gambar tidak berubah.

**8. Mengapa foto harus didaftarkan di `pubspec.yaml`?**
Flutter perlu tahu aset mana yang harus dimasukkan ke dalam bundle aplikasi. Tanpa pendaftaran, `Image.asset` akan gagal memuat gambar.

**9. Apa fungsi `errorBuilder` pada `Image.asset`?**
Menampilkan widget alternatif ketika gambar gagal dimuat, sehingga aplikasi tetap berjalan dan tidak menampilkan error merah.

**10. Apa perbedaan `Row` dan `Wrap`?**
`Row` memaksa semua anak dalam satu baris dan bisa overflow. `Wrap` otomatis memindahkan anak ke baris baru jika ruang tidak cukup.

**11. Apa fungsi `SafeArea`?**
Menghindari konten tertutup notch, kamera depan, atau status bar.

**12. Apa itu `BuildContext`?**
Objek yang menunjukkan posisi widget dalam widget tree dan memberi akses ke tema, MediaQuery, navigasi, dan lainnya.

**13. Mengapa menggunakan custom widget?**
Agar kode tidak duplikat, lebih mudah dibaca, dan perubahan tampilan cukup dilakukan di satu tempat.

**14. Apa fungsi `const`?**
Menandai nilai atau widget yang sudah tetap saat compile-time sehingga lebih efisien dan tidak dibuat ulang saat rebuild.

**15. Bagaimana cara mengganti data biodata?**
Ubah konstanta `namaLengkap`, `nim`, `kelas`, dan `tempatTanggalLahir` di bagian atas `lib/main.dart`, lalu ganti `assets/foto.jpg` dan jalankan hot restart.

---

## 5. Checklist Sebelum Merekam

- [ ] Aplikasi sudah dijalankan minimal sekali (`flutter run`).
- [ ] Data dan foto sudah benar.
- [ ] Source code dibuka di editor dengan font cukup besar.
- [ ] Emulator/HP terlihat bersama source code.
- [ ] Durasi latihan di bawah 5 menit.
- [ ] Microphone jelas dan tidak ada suara latar mengganggu.
- [ ] Sudah menyebutkan nama, NIM, dan kelas di awal video.
- [ ] Menunjukkan aplikasi berjalan, bukan hanya kode.
