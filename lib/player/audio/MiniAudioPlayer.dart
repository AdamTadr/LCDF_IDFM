import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:lcdf_idfm/container/MediaContainer.dart';

class MiniAudioPlayer extends StatefulWidget {
  final MediaContent media;

  const MiniAudioPlayer({super.key, required this.media});

  @override
  State<MiniAudioPlayer> createState() => _MiniAudioPlayerState();
}

class _MiniAudioPlayerState extends State<MiniAudioPlayer> {
  late AudioPlayer _player;
  bool _ready = false;
  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _player.setVolume(1);
    _init();
  }

  Future<void> _init() async {
    try {
      await _player.setAudioSource(AudioSource.asset(widget.media.Path));
      setState(() {
        _ready = true;
      });
    } catch (e) {
      print("Erreur fichié audio: $e");
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) return Center(child: const CircularProgressIndicator());
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          children: [
            StreamBuilder<PlayerState>(
              stream: _player.playerStateStream,
              builder: (context, snapshot) {
                return IconButton(
                  onPressed: () {
                    if (_player.playing) {
                      _player.pause();
                    } else {
                      _player.play();
                    }
                  },
                  icon: Icon(
                    _player.playing ? Icons.pause_circle : Icons.play_circle,
                    size: 45,
                  ),
                );
              },
            ),
            SizedBox(width: 20),
            StreamBuilder<Duration>(
              stream: _player.positionStream,
              builder: (context, snapshot) {
                final position = snapshot.data ?? Duration.zero;
                final duration = _player.duration ?? Duration.zero;

                return Row(
                  children: [
                    SizedBox(
                      width: screenWidth * 0.6,
                      child: ProgressBar(
                        progress: position,
                        total: duration,
                        onSeek: (newPosition) => _player.seek(newPosition),
                        timeLabelTextStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        Text(widget.media.description),
        Text(
          widget.media.credits,
          style: TextStyle(decoration: TextDecoration.underline),
        ),
      ],
    );
  }
}
