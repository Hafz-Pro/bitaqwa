import 'package:flutter/material.dart';
import 'package:bitaqwa/util/color_constant.dart';

class DetailDoaScreen extends StatelessWidget {
  final String title;
  final String arabicText;
  final String translation;
  final String reference;

  const DetailDoaScreen({
    super.key,
    required this.title,
    required this.arabicText,
    required this.translation,
    required this.reference,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF4FC),
      appBar: AppBar(
        title: const Text('Detail Doa'),
        centerTitle: true,
        backgroundColor: ColorConstant.colorPrimary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.colorSecondary,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                arabicText,
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                  fontSize: 29,
                  height: 2,
                  color: Color(0xFF25202A),
                ),
              ),
              const SizedBox(height: 22),
              const Divider(),
              const SizedBox(height: 12),
              const Text(
                'Terjemahan',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.colorPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                translation,
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 15, height: 1.7),
              ),
              const SizedBox(height: 22),
              const Text(
                'Referensi',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.colorPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(reference, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
