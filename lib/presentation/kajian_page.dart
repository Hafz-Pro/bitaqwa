import 'package:flutter/material.dart';
import 'package:bitaqwa/presentation/detail_kajian_page.dart';
import 'package:bitaqwa/util/color_constant.dart';

class KajianPage extends StatelessWidget {
  const KajianPage({super.key});

  static const List<Map<String, String>> videos = [
    {
      'channel': 'Khalid Basalamah Official',
      'ustadz': 'Ustadz Khalid Basalamah',
      'judul': 'Kajian Khalid Basalamah',
      'videoId': 'J5ky4ofT-d0',
      'isi':
          'Tambahkan ringkasan yang sudah diperiksa dari isi video asli di sini.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3FA),
      appBar: AppBar(
        title: const Text('Video Kajian'),
        centerTitle: true,
        backgroundColor: ColorConstant.colorPrimary,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(7),
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final video = videos[index];
          final id = video['videoId']!;
          final thumbnail = 'https://img.youtube.com/vi/$id/hqdefault.jpg';
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 0,
            color: const Color(0xFFF7F2F9),
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
                side: const BorderSide(color: Color(0xFFD9D1DC))),
            child: InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => DetailKajianPage(kajian: video))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned.fill(
                            child: Image.network(thumbnail,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => const ColoredBox(
                                    color: Color(0xFFE5DDE9),
                                    child: Center(
                                        child: Icon(Icons.video_library,
                                            size: 60))))),
                        Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.35),
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: ColorConstant.colorPrimary,
                                    width: 3)),
                            child: const Icon(Icons.play_arrow_rounded,
                                color: ColorConstant.colorPrimary, size: 36)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(9),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(video['channel']!,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 12)),
                          const SizedBox(height: 7),
                          Text(video['ustadz']!,
                              style: const TextStyle(
                                  color: ColorConstant.colorPrimary,
                                  fontSize: 14)),
                          const SizedBox(height: 3),
                          Text(video['judul']!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                        ]),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
