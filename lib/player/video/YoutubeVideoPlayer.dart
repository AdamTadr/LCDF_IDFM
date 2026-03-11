import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class YoutubeVideoPlayer extends StatelessWidget {
  final String videoId;
  const YoutubeVideoPlayer({super.key, required this.videoId});

  Future<void> _openYoutube() async {
    final url = Uri.parse('https://www.youtube.com/watch?v=$videoId');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Impossible d\'ouvrir YouTube');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openYoutube,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://img.youtube.com/vi/$videoId/maxresdefault.jpg',
              fit: BoxFit.cover,
            ),
            const Center(
              child: Icon(
                Icons.play_circle_outline,
                size: 64,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
