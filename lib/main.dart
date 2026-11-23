
import 'package:flutter/material.dart';

import 'dashboard_screen.dart';
import 'presentation/screen/doa_screen.dart';
import 'presentation/zakat_screen.dart';
import 'presentation/sholat_page.dart';
import 'presentation/kajian_page.dart';


void main() {
  runApp(const BitaqwaApp());
}

class BitaqwaApp extends StatelessWidget {
  const BitaqwaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bitaqwa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFFF9FC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF936D),
          primary: const Color(0xFFFF936D),
          secondary: const Color(0xFF69566F),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const DashboardScreen(),
        '/doa': (_) => const DoaScreen(),
        '/zakat': (_) => const ZakatScreen(),
        '/sholat': (_) => const SholatPage(),
        '/jadwal-sholat': (_) => const SholatPage(),
        '/kajian': (_) => const KajianPage(),
      },
    );
  }
}
