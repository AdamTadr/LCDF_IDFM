import 'package:flutter/material.dart';
import 'package:lcdf_idfm/container/MediaContainer.dart';
import 'package:lcdf_idfm/button/BtnRound.dart';
import 'package:lcdf_idfm/container/Carrousel.dart';
import 'package:lcdf_idfm/player/audio/MiniAudioPlayer.dart';
import 'package:lcdf_idfm/text/MainTitle.dart';
import 'package:lcdf_idfm/text/SubTitle.dart';

class Mediatheque extends StatefulWidget {
  String title;
  MediaContainer media;
  Mediatheque({super.key, required this.title, required this.media});
  @override
  State<Mediatheque> createState() => _MediathequeState();
}

class _MediathequeState extends State<Mediatheque> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 110,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            MainTitle(title: "Mediatheque de la ${widget.title}"),
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
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Carrousel(
                images: widget.media.images,
                title: "Images",
                zoomable: true,
              ),
              SizedBox(height: 30),
              Carrousel(
                videos: widget.media.videos,
                title: "Videos",
                zoomable: true,
              ),
              SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SubTitle(title: "Sons"),
                  SizedBox(height: 20),
                  for (var son in widget.media.sons) ...[
                    MiniAudioPlayer(media: son),
                    SizedBox(height: 10),
                    Divider(
                      color: Colors.grey,
                      thickness: 2,
                      indent: 20,
                      endIndent: 20,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
