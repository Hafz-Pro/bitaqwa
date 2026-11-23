# Bitaqwa — starter source project

Paket ini berisi sumber aplikasi Flutter Bitaqwa: dashboard, modul doa, kalkulator zakat, jadwal sholat, dan video kajian.

## A. Membuat proyek Flutter dari awal (cara yang disarankan)

1. Pastikan Flutter SDK dan VS Code sudah terpasang. Di terminal jalankan `flutter doctor`.
2. Buat proyek baru:

   ```bash
   flutter create bitaqwa
   ```

3. Ekstrak ZIP ini. Salin folder `lib/`, folder `assets/`, dan file `pubspec.yaml` dari paket ini ke folder proyek `bitaqwa/`. Pilih **Replace** saat diminta mengganti `pubspec.yaml`.
4. Buka terminal di folder `bitaqwa`, lalu jalankan:

   ```bash
   flutter pub add http youtube_player_flutter
   flutter pub get
   flutter run -d chrome
   ```

5. Untuk menjalankan di Android, sambungkan HP atau buka emulator, lalu jalankan `flutter run`.

## B. Struktur kode

```text
lib/
├── main.dart
├── dashboard_screen.dart
├── data/
│   ├── doa_model.dart
│   ├── kategori_doa_model.dart
│   ├── kategori_doa_data.dart
│   └── dummy/doa_data.dart
├── enum/kategori_doa_enum.dart
├── extention/kategori_doa_ext.dart
├── presentation/
│   ├── widget/card_doa.dart
│   ├── screen/doa_screen.dart
│   ├── screen/doa_list_screen.dart
│   ├── screen/detail_doa_screen.dart
│   ├── zakat_screen.dart
│   ├── sholat_page.dart
│   ├── kajian_page.dart
│   └── detail_kajian_page.dart
└── util/color_constant.dart
```

## C. Kategori doa tambahan

Tugas meminta satu kategori baru. Paket ini menambahkan `DoaCategory.belajar` / **Doa Belajar** pada enum, data kategori, extension, dan `doa_data.dart`.

## D. Catatan konten

- File `doa_data.dart` pada instruksi tugas disebut sebagai file unduhan, tetapi file tersebut tidak disertakan di pesan. Karena itu paket ini berisi **data contoh awal**, bukan pengganti resmi file dari guru. Periksa teks Arab, terjemahan, dan referensinya dengan guru atau sumber tepercaya sebelum aplikasi dipakai sebagai rujukan ibadah.
- Video menggunakan ID YouTube yang telah kamu kirim: `J5ky4ofT-d0`. Judul dibuat generik karena judul asli video belum terverifikasi. Ringkasan di halaman detail masih berupa placeholder.
- Thumbnail kajian diambil langsung dari YouTube memakai ID video, bukan dari aset lokal.
- Ikon kategori disediakan sebagai PNG sederhana dan `CardDoa` memiliki fallback ikon Material.

## E. Acuan perhitungan zakat

- Harga acuan: Antam 1 gram Rp2.509.000, data 13 November 2026 (snapshot terbaru yang berhasil diverifikasi saat paket disusun).
- Nisab simulasi: 85 × Rp2.509.000 = **Rp213.265.000**.
- Kadar simulasi: 2,5% jika harta mencapai nisab.
- Harga pada kode bersifat statis dan **tidak diperbarui otomatis**. Perbarui `hargaEmasPerGram` serta tanggal sumber secara manual.
- Kalkulator ini demo dasar. Ia belum menilai jenis harta, utang, haul, dan syarat zakat lainnya.

## F. Jadwal sholat

- Lokasi dikunci ke Karanganyar, Central Java, Indonesia.
- Menggunakan AlAdhan API dengan `method=20` (KEMENAG RI) dan `school=0`.
- Hasil API pihak ketiga dapat berbeda dari jadwal resmi daerah. Cocokkan dengan Kemenag atau masjid setempat.
