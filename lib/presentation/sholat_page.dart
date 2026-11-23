import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SholatPage extends StatefulWidget {
  const SholatPage({super.key});

  @override
  State<SholatPage> createState() => _SholatPageState();
}

class _SholatPageState extends State<SholatPage> {
  // =========================================================================
  // PENGATURAN GAMBAR BANNER (Bisa diganti dengan gambar dari laptop Anda)
  // Simpan file gambar Anda di folder: assets/images/
  // =========================================================================
  static const String bannerMalamPath = 'assets/images/bg_sholat_malam.png';
  static const String bannerSiangPath = 'assets/images/bg_sholat_siang.png';

  static const String kota = 'Karanganyar';
  static const String provinsi = 'Central Java';
  static const String negara = 'Indonesia';

  // Nilai default awal (sesuai screenshot) agar UI langsung tampil rapi tanpa loading lama
  Map<String, String> jadwal = {
    'Fajr': '04:12',
    'Dhuhr': '11:31',
    'Asr': '14:45',
    'Maghrib': '17:33',
    'Isha': '18:42',
  };

  final List<Map<String, String>> daftarSholat = const [
    {'nama': 'Subuh', 'key': 'Fajr'},
    {'nama': 'Dzuhur', 'key': 'Dhuhr'},
    {'nama': 'Ashar', 'key': 'Asr'},
    {'nama': 'Maghrib', 'key': 'Maghrib'},
    {'nama': 'Isya', 'key': 'Isha'},
  ];

  @override
  void initState() {
    super.initState();
    ambilJadwal();
  }

  /// Mengecek apakah saat ini malam atau siang secara otomatis
  /// Malam: setelah Maghrib hingga sebelum Subuh (atau jam 18:00 - 05:00)
  /// Siang: setelah Subuh hingga sebelum Maghrib (atau jam 05:00 - 18:00)
  bool get isNight {
    final now = DateTime.now();
    if (jadwal.containsKey('Maghrib') && jadwal.containsKey('Fajr')) {
      try {
        final maghribParts = (jadwal['Maghrib'] ?? '').split(':');
        final subuhParts = (jadwal['Fajr'] ?? '').split(':');

        if (maghribParts.length >= 2 && subuhParts.length >= 2) {
          final maghribHour = int.tryParse(maghribParts[0].trim()) ?? 18;
          final maghribMinute = int.tryParse(maghribParts[1].trim()) ?? 0;
          final subuhHour = int.tryParse(subuhParts[0].trim()) ?? 4;
          final subuhMinute = int.tryParse(subuhParts[1].trim()) ?? 12;

          final maghribToday = DateTime(
            now.year,
            now.month,
            now.day,
            maghribHour,
            maghribMinute,
          );
          final subuhToday = DateTime(
            now.year,
            now.month,
            now.day,
            subuhHour,
            subuhMinute,
          );

          return now.isAfter(maghribToday) || now.isBefore(subuhToday);
        }
      } catch (_) {}
    }
    return now.hour >= 18 || now.hour < 5;
  }

  /// Path gambar banner otomatis (siang vs malam)
  String get currentBannerImage => isNight ? bannerMalamPath : bannerSiangPath;

  String tanggalApi(DateTime date) {
    final d = date.day.toString().padLeft(2, '0');
    final m = date.month.toString().padLeft(2, '0');
    return '$d-$m-${date.year}';
  }

  String tanggalLokal(DateTime date) {
    const hari = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
    const bulan = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return '${hari[date.weekday - 1]}, ${date.day} ${bulan[date.month - 1]}';
  }

  Future<void> ambilJadwal() async {
    try {
      final date = tanggalApi(DateTime.now());
      final uri = Uri.https(
        'api.aladhan.com',
        '/v1/timingsByCity/$date',
        {
          'city': kota,
          'state': provinsi,
          'country': negara,
          'method': '20', // Kemenag RI
          'school': '0',
        },
      );

      final response = await http.get(uri).timeout(const Duration(seconds: 15));
      if (response.statusCode != 200) return;

      final json = jsonDecode(response.body) as Map<String, dynamic>;
      if (json['code'] != 200) return;
      final data = json['data'] as Map<String, dynamic>?;
      if (data == null || data['timings'] == null) return;
      final timings = data['timings'] as Map<String, dynamic>;
      final Map<String, String> result = {};

      for (final item in daftarSholat) {
        final key = item['key'] ?? '';
        final raw = timings[key]?.toString();
        if (raw != null && raw.isNotEmpty) {
          result[key] = raw.length >= 5 ? raw.substring(0, 5) : raw;
        }
      }

      if (!mounted || result.isEmpty) return;
      setState(() {
        jadwal = result;
      });
    } catch (_) {
      // Jika offline atau error jaringan, tetap gunakan data default
    }
  }

  /// Mengambil jadwal sholat terdekat berikutnya untuk ditampilkan di banner utama
  Map<String, String> get sholatBerikutnya {
    try {
      final now = DateTime.now();
      for (final item in daftarSholat) {
        final time = jadwal[item['key']];
        if (time == null || !time.contains(':')) continue;
        final parts = time.split(':');
        final hour = int.tryParse(parts[0].trim()) ?? 0;
        final minute = int.tryParse(parts[1].trim()) ?? 0;
        final prayerTime = DateTime(
          now.year,
          now.month,
          now.day,
          hour,
          minute,
        );
        if (prayerTime.isAfter(now)) {
          return {'nama': item['nama'] ?? 'Sholat', 'jam': time};
        }
      }
    } catch (_) {}
    return {'nama': 'Subuh', 'jam': jadwal['Fajr'] ?? '04:12'};
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Scaffold(
      backgroundColor: const Color(0xFFE5F2FC),
      appBar: AppBar(
        title: const Text(
          'Jadwal Sholat',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFE2815B),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacementNamed(context, '/');
            }
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: ambilJadwal,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // =============================================================
              // 1. BAGIAN BANNER (Berupa Gambar yang berganti otomatis)
              // =============================================================
              _buildBannerSection(now),

              // =============================================================
              // 2. KARTU DAFTAR WAKTU SHOLAT (Menimpa bagian bawah banner)
              // =============================================================
              _buildPrayerCard(),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  /// Banner gambar dengan informasi waktu sholat di atasnya
  Widget _buildBannerSection(DateTime now) {
    final prayer = sholatBerikutnya;

    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Gambar Background Banner (otomatis berganti siang / malam)
          Positioned.fill(
            child: Image.asset(
              currentBannerImage,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Tampilan cadangan jika file gambar belum dimasukkan
                return Container(
                  color: isNight ? const Color(0xFF6B8795) : const Color(0xFF5C9DCE),
                  child: Center(
                    child: Icon(
                      isNight ? Icons.nightlight_round : Icons.wb_sunny_rounded,
                      size: 60,
                      color: Colors.white24,
                    ),
                  ),
                );
              },
            ),
          ),

          // Teks Informasi di atas Gambar Banner
          Positioned(
            top: 18,
            left: 20,
            right: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Tanggal Hari Ini (misal: Selasa, 15 September)
                Text(
                  tanggalLokal(now),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                // Nama Sholat Berikutnya (misal: Dzuhur)
                Text(
                  prayer['nama'] ?? 'Dzuhur',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),

                // Jam Sholat (misal: 11:31)
                Text(
                  prayer['jam'] ?? '11:31',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 8),

                // Lokasi Kota dengan Pin Oranye
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Color(0xFFE2815B),
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      kota,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Kartu putih berisi daftar 5 waktu sholat dengan ikon alarm
  Widget _buildPrayerCard() {
    return Transform.translate(
      offset: const Offset(0, -32),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: List.generate(daftarSholat.length, (index) {
            final item = daftarSholat[index];
            final isLast = index == daftarSholat.length - 1;
            final time = jadwal[item['key']] ?? '--:--';

            return Container(
              padding: const EdgeInsets.symmetric(vertical: 13),
              decoration: BoxDecoration(
                border: isLast
                    ? null
                    : const Border(
                        bottom: BorderSide(
                          color: Color(0xFFB8DED2),
                          width: 1.2,
                        ),
                      ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      item['nama'] ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Image.asset(
                    'assets/images/ic_clock.png',
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.alarm,
                      color: Color(0xFFF2994A),
                      size: 22,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
