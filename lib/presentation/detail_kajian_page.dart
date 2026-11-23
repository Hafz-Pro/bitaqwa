import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:bitaqwa/util/color_constant.dart';

class DetailKajianPage extends StatefulWidget {
  final Map<String, String> kajian;
  const DetailKajianPage({super.key, required this.kajian});

  @override
  State<DetailKajianPage> createState() => _DetailKajianPageState();
}

class _DetailKajianPageState extends State<DetailKajianPage> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.kajian['videoId']!,
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final video = widget.kajian;
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8FF),
      appBar: AppBar(
        title: Text(video['judul'] ?? 'Detail Kajian', maxLines: 1, overflow: TextOverflow.ellipsis),
        centerTitle: true,
        backgroundColor: ColorConstant.colorPrimary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          YoutubePlayer(controller: _controller, showVideoProgressIndicator: true, progressIndicatorColor: ColorConstant.colorPrimary),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(video['channel'] ?? '', style: const TextStyle(color: Colors.grey, fontSize: 12)),
              const SizedBox(height: 8),
              Text(video['ustadz'] ?? '', style: const TextStyle(color: ColorConstant.colorPrimary)),
              const SizedBox(height: 12),
              Text(video['judul'] ?? '', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Text(video['isi'] ?? '', textAlign: TextAlign.justify, style: const TextStyle(fontSize: 14, height: 1.7)),
              const SizedBox(height: 20),
              const Text('Catatan: ringkasan ini perlu disesuaikan dengan isi video yang sebenarnya.', style: TextStyle(fontSize: 11, color: Colors.black54)),
            ]),
          ),
        ],
      ),
    );
  }
}
