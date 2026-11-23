import 'package:flutter/material.dart';
import 'package:bitaqwa/util/color_constant.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  // =========================================================================
  // PENGATURAN GAMBAR (Bisa diganti dengan gambar apa saja dari laptop Anda)
  // =========================================================================

  /// 1. Gambar Header (gambar pemandangan matahari & ucapan Assalamualaikum)
  /// Cukup ganti path ini atau ganti file gambar di folder assets/images/header.png
  static const String headerImage = 'assets/images/header.png';

  /// 2. Daftar Gambar Inspirasi
  /// Anda bisa menambahkan, mengganti, atau menghapus gambar di dalam list ini.
  /// Gambar baru cukup ditaruh di assets/images/ lalu daftarkan path-nya di sini.
  static const List<String> inspirasiList = [
    'assets/images/inspirasi_1.png',
    'assets/images/inspirasi_2.png',
    // 'assets/images/inspirasi_3.png', // Tambahkan gambar baru di sini jika ada
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===============================================================
            // 1. HEADER (Gambar Assalamualaikum & Matahari murni berupa Image)
            // ===============================================================
            _buildHeaderImage(),

            const SizedBox(height: 14),

            // ===============================================================
            // 2. KOTAK MENU ORANYE (Doa-doa, Zakat, Jadwal Sholat, Video Kajian)
            // ===============================================================
            _buildMenuCard(context),

            const SizedBox(height: 22),

            // ===============================================================
            // 3. JUDUL INSPIRASI
            // ===============================================================
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Inspirasi',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // ===============================================================
            // 4. DAFTAR GAMBAR INSPIRASI (Murni berupa Image dari laptop)
            // ===============================================================
            _buildInspirasiSection(),

            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }

  /// Menampilkan gambar banner header
  Widget _buildHeaderImage() {
    return Image.asset(
      headerImage,
      width: double.infinity,
      fit: BoxFit.fitWidth,
      errorBuilder: (context, error, stackTrace) {
        // Tampilan cadangan sederhana jika file gambar belum dimasukkan
        return Container(
          width: double.infinity,
          height: 220,
          color: const Color(0xFFE3F2FD),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.image_outlined, size: 52, color: Colors.blueGrey[300]),
              const SizedBox(height: 8),
              Text(
                'Silakan letakkan gambar header di:\n$headerImage',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blueGrey[600], fontSize: 13),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Menampilkan kotak menu oranye dengan 4 tombol
  Widget _buildMenuCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE2815B),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE2815B).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMenuItem(
            title: 'Doa-doa',
            icon: Icons.volunteer_activism_rounded,
            onTap: () => Navigator.pushNamed(context, '/doa'),
          ),
          _buildMenuItem(
            title: 'Zakat',
            icon: Icons.calculate_rounded,
            onTap: () => Navigator.pushNamed(context, '/zakat'),
          ),
          _buildMenuItem(
            title: 'Jadwal Sholat',
            icon: Icons.access_time_filled_rounded,
            onTap: () => Navigator.pushNamed(context, '/sholat'),
          ),
          _buildMenuItem(
            title: 'Video Kajian',
            icon: Icons.ondemand_video_rounded,
            onTap: () => Navigator.pushNamed(context, '/kajian'),
          ),
        ],
      ),
    );
  }

  /// Satu item tombol menu dalam kotak oranye
  Widget _buildMenuItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: const BoxDecoration(
              color: ColorConstant.colorSecondary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                icon,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  /// Menampilkan kumpulan kotak inspirasi yang bersumber dari daftar gambar
  Widget _buildInspirasiSection() {
    return ListView.builder(
      itemCount: inspirasiList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        final imagePath = inspirasiList[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              imagePath,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Tampilan cadangan jika file gambar belum tersedia
                return Container(
                  height: 180,
                  color: Colors.grey[200],
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image_outlined, size: 42, color: Colors.grey[400]),
                        const SizedBox(height: 6),
                        Text(
                          'Gambar tidak ditemukan:\n$imagePath',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey[600], fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
