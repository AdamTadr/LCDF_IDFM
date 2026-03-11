import 'package:flutter/material.dart';
import 'package:lcdf_idfm/container/MediaContainer.dart';
import 'package:lcdf_idfm/container/TextZone.dart';
import 'package:lcdf_idfm/player/audio/MiniAudioPlayer.dart';
import 'package:lcdf_idfm/button/BtnRound.dart';
import 'package:lcdf_idfm/container/Carrousel.dart';
import 'package:lcdf_idfm/text/SubTitle.dart';

enum ContentType { img, video, txt, sound, title }

class HistoryScreen extends StatefulWidget {
  final String title;
  final String Category;
  final MediaContainer mediaContainers;

  const HistoryScreen({
    super.key,
    required this.mediaContainers,
    required this.title,
    required this.Category,
  });
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  ContentType getContentType(String line) {
    return line.startsWith('img')
        ? ContentType.img
        : line.startsWith('video')
        ? ContentType.video
        : line.startsWith('sound')
        ? ContentType.sound
        : line.startsWith('title')
        ? ContentType.title
        : ContentType.txt;
  }

  Widget pageConstructor(MediaContainer mediaContainers, int indice) {
    String para = mediaContainers.ParagrHist[indice];
    List<MediaContent> media = [];
    ContentType contentType = getContentType(para);
    late Widget returnWidg;

    if (contentType == ContentType.img || contentType == ContentType.video) {
      List<int> indicesContents = [];
      while (para.contains('-')) {
        int indiceImg = int.parse(para.split('-').last);
        para = para.split('-').sublist(0, para.split('-').length - 1).join('-');
        indicesContents.add(indiceImg);
      }
      if (contentType == ContentType.img) {
        for (var ind in indicesContents) {
          media.add(mediaContainers.images[ind]);
          returnWidg = Carrousel(images: media);
        }
      } else {
        for (var ind in indicesContents) {
          media.add(mediaContainers.videos[ind]);
          returnWidg = Carrousel(videos: media);
        }
      }
    } else if (contentType == ContentType.sound) {
      return MiniAudioPlayer(
        media: mediaContainers.sons[int.parse(para.split('-').last)],
      );
    } else if (contentType == ContentType.title) {
      return SubTitle(title: para.split('-').last);
    } else {
      returnWidg = TextZone(text: para);
    }
    return Column(children: [returnWidg, SizedBox(height: 20)]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 110,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            SubTitle(
              title: "L'histoire de la ${widget.title} du ${widget.Category}",
            ),
            const SizedBox(width: 10),
            BtnRound(
              isUnactive: false,
              action: () {
                Navigator.of(context).pop();
              },
              rotation: 3.14,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (
                  int i = 0;
                  i < widget.mediaContainers.ParagrHist.length;
                  i++
                ) ...[
                  SizedBox(
                    width: double.infinity,
                    child: pageConstructor(widget.mediaContainers, i),
                  ),
                  SizedBox(height: 20),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
