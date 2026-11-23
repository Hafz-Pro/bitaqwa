import 'package:bitaqwa/data/doa_model.dart';
import 'package:bitaqwa/enum/kategori_doa_enum.dart';

// DATA CONTOH AWAL.
// Periksa teks Arab, terjemahan, dan rujukan dengan guru/sumber tepercaya
// sebelum aplikasi dipakai sebagai referensi ibadah.
const Map<DoaCategory, List<Doa>> doaData = {
  DoaCategory.makananMinuman: [
    Doa(
      image: 'assets/doa/default.png',
      title: 'Doa Sebelum Makan',
      arabicText: 'بِسْمِ اللَّهِ',
      translation: 'Dengan nama Allah.',
      reference: 'HR. Abu Dawud dan Tirmidzi',
    ),
    Doa(
      image: 'assets/doa/default.png',
      title: 'Doa Setelah Makan',
      arabicText: 'الْحَمْدُ لِلَّهِ الَّذِي أَطْعَمَنِي هَذَا وَرَزَقَنِيهِ مِنْ غَيْرِ حَوْلٍ مِنِّي وَلَا قُوَّةٍ',
      translation: 'Segala puji bagi Allah yang telah memberiku makanan ini dan menganugerahkannya kepadaku tanpa daya dan kekuatanku.',
      reference: 'HR. Abu Dawud dan Tirmidzi',
    ),
  ],
  DoaCategory.pagiMalam: [
    Doa(
      image: 'assets/doa/default.png',
      title: 'Dzikir Pagi',
      arabicText: 'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ',
      translation: 'Kami memasuki waktu pagi dan kerajaan hanya milik Allah.',
      reference: 'HR. Muslim — bagian dari dzikir pagi',
    ),
    Doa(
      image: 'assets/doa/default.png',
      title: 'Dzikir Petang',
      arabicText: 'أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ',
      translation: 'Kami memasuki waktu petang dan kerajaan hanya milik Allah.',
      reference: 'HR. Muslim — bagian dari dzikir petang',
    ),
  ],
  DoaCategory.rumah: [
    Doa(
      image: 'assets/doa/default.png',
      title: 'Doa Masuk Rumah',
      arabicText: 'بِسْمِ اللَّهِ وَلَجْنَا، وَبِسْمِ اللَّهِ خَرَجْنَا، وَعَلَى اللَّهِ رَبِّنَا تَوَكَّلْنَا',
      translation: 'Dengan nama Allah kami masuk, dengan nama Allah kami keluar, dan kepada Allah Tuhan kami, kami bertawakal.',
      reference: 'HR. Abu Dawud',
    ),
  ],
  DoaCategory.perjalanan: [
    Doa(
      image: 'assets/doa/default.png',
      title: 'Doa Naik Kendaraan',
      arabicText: 'سُبْحَانَ الَّذِي سَخَّرَ لَنَا هَذَا وَمَا كُنَّا لَهُ مُقْرِنِينَ',
      translation: 'Mahasuci Allah yang telah menundukkan kendaraan ini bagi kami, padahal kami sebelumnya tidak mampu menguasainya.',
      reference: 'QS. Az-Zukhruf: 13',
    ),
  ],
  DoaCategory.sholat: [
    Doa(
      image: 'assets/doa/default.png',
      title: 'Doa Masuk Masjid',
      arabicText: 'اللَّهُمَّ افْتَحْ لِي أَبْوَابَ رَحْمَتِكَ',
      translation: 'Ya Allah, bukakanlah untukku pintu-pintu rahmat-Mu.',
      reference: 'HR. Muslim',
    ),
  ],
  DoaCategory.etikaBaik: [
    Doa(
      image: 'assets/doa/default.png',
      title: 'Doa Ketika Bersin',
      arabicText: 'الْحَمْدُ لِلَّهِ',
      translation: 'Segala puji bagi Allah.',
      reference: 'HR. Bukhari',
    ),
  ],
  DoaCategory.belajar: [
    Doa(
      image: 'assets/doa/default.png',
      title: 'Doa Memohon Tambahan Ilmu',
      arabicText: 'رَبِّ زِدْنِي عِلْمًا',
      translation: 'Ya Tuhanku, tambahkanlah ilmu kepadaku.',
      reference: 'QS. Taha: 114',
    ),
  ],
};
