import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bitaqwa/util/color_constant.dart';

class ZakatScreen extends StatefulWidget {
  const ZakatScreen({super.key});

  @override
  State<ZakatScreen> createState() => _ZakatScreenState();
}

class _ZakatScreenState extends State<ZakatScreen> {
  // Snapshot harga Antam 1 gram per 13 November 2026.
  // Perbarui angka ini saat memakai harga emas yang lebih baru.
  static const int hargaEmasPerGram = 2509000;
  static const int nisabEmasGram = 85;
  static const double kadarZakat = 0.025;

  final TextEditingController _hartaController = TextEditingController();
  int totalHarta = 0;
  bool sudahDihitung = false;

  int get nisabRupiah => hargaEmasPerGram * nisabEmasGram;
  bool get mencapaiNisab => totalHarta >= nisabRupiah;
  double get zakat => mencapaiNisab ? totalHarta * kadarZakat : 0;

  String formatRupiah(num value) {
    final fixed = value.toStringAsFixed(2).split('.');
    final grouped = fixed[0].replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (_) => '.',
    );
    return 'Rp. $grouped,${fixed[1]}';
  }

  void hitung() {
    final angka = int.tryParse(_hartaController.text.replaceAll('.', ''));
    if (angka == null || angka <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan total harta yang valid.')),
      );
      return;
    }
    setState(() {
      totalHarta = angka;
      sudahDihitung = true;
    });
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _hartaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8FF),
      appBar: AppBar(
        title: const Text('Zakat'),
        centerTitle: true,
        backgroundColor: ColorConstant.colorPrimary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 170,
              decoration: BoxDecoration(
                color: const Color(0xFFF1E8F3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.volunteer_activism_rounded,
                size: 100,
                color: ColorConstant.colorSecondary,
              ),
            ),
            const SizedBox(height: 22),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFF0EEEE),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Harta',
                    style: TextStyle(
                      color: ColorConstant.colorPrimary,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _hartaController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      prefixText: 'Rp. ',
                      labelText: 'Masukkan total harta',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: hitung,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.colorPrimary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                      ),
                      child: const Text('HITUNG ZAKAT'),
                    ),
                  ),
                ],
              ),
            ),
            if (sudahDihitung) ...[
              const SizedBox(height: 18),
              _resultCard('Total Uang', formatRupiah(totalHarta), const Color(0xFFD97878)),
              const SizedBox(height: 12),
              _resultCard('Zakat Dikeluarkan', formatRupiah(zakat), const Color(0xFFB264C5)),
            ],
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2D7E7)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Informasi Nisab',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.colorSecondary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _infoRow('Harga emas / gram', formatRupiah(hargaEmasPerGram)),
                  _infoRow('Nisab (85 gram)', formatRupiah(nisabRupiah)),
                  _infoRow('Kadar zakat mal', '2,5%'),
                  const SizedBox(height: 12),
                  if (sudahDihitung)
                    Text(
                      mencapaiNisab
                          ? 'Harta mencapai nilai nisab. Pastikan syarat haul dan ketentuan zakat lainnya terpenuhi.'
                          : 'Harta belum mencapai nilai nisab berdasarkan harga acuan ini.',
                      style: TextStyle(
                        color: mencapaiNisab ? Colors.green.shade800 : Colors.red.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  const SizedBox(height: 12),
                  const Text(
                    'Acuan harga Antam 1 gram per 13 November 2026. '
                    'Harga dapat berubah. Kalkulator ini simulasi dasar; '
                    'jenis harta, utang, haul, dan ketentuan zakat lainnya '
                    'belum diperiksa. Konsultasikan dengan lembaga zakat tepercaya.',
                    style: TextStyle(fontSize: 11, color: Colors.black54, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _resultCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 8),
          FittedBox(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(child: Text(title)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
