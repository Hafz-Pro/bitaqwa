import 'package:flutter/material.dart';
import 'package:bitaqwa/enum/kategori_doa_enum.dart';

extension KategoriDoaExt on DoaCategory {
  String get title {
    switch (this) {
      case DoaCategory.makananMinuman:
        return 'Makanan & Minuman';
      case DoaCategory.pagiMalam:
        return 'Pagi & Malam';
      case DoaCategory.rumah:
        return 'Doa di Rumah';
      case DoaCategory.perjalanan:
        return 'Perjalanan';
      case DoaCategory.sholat:
        return 'Sholat';
      case DoaCategory.etikaBaik:
        return 'Etika Baik';
      case DoaCategory.belajar:
        return 'Doa Belajar';
    }
  }

  String get image {
    switch (this) {
      case DoaCategory.makananMinuman:
        return 'assets/icons/makanan.png';
      case DoaCategory.pagiMalam:
        return 'assets/icons/pagi_malam.png';
      case DoaCategory.rumah:
        return 'assets/icons/rumah.png';
      case DoaCategory.perjalanan:
        return 'assets/icons/perjalanan.png';
      case DoaCategory.sholat:
        return 'assets/icons/sholat.png';
      case DoaCategory.etikaBaik:
        return 'assets/icons/etika.png';
      case DoaCategory.belajar:
        return 'assets/icons/belajar.png';
    }
  }

  IconData get icon {
    switch (this) {
      case DoaCategory.makananMinuman:
        return Icons.restaurant_rounded;
      case DoaCategory.pagiMalam:
        return Icons.wb_twilight_rounded;
      case DoaCategory.rumah:
        return Icons.home_rounded;
      case DoaCategory.perjalanan:
        return Icons.directions_car_rounded;
      case DoaCategory.sholat:
        return Icons.mosque_rounded;
      case DoaCategory.etikaBaik:
        return Icons.volunteer_activism_rounded;
      case DoaCategory.belajar:
        return Icons.menu_book_rounded;
    }
  }
}
