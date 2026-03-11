import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lcdf_idfm/container/MediaContainer.dart';
import 'package:lcdf_idfm/container/Carrousel.dart';
import 'package:lcdf_idfm/text/MainTitle.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MainTitle(title: 'Bon retour parmi nous ! 👋 '),
        centerTitle: false,
        toolbarHeight: 110,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Carrousel(
              images: [
                MediaContent(
                  Path: "assets/press/questionTest.png",
                  credits: 'moi - 1',
                  description: 'test test test test 1',
                ),
                MediaContent(
                  Path: "assets/press/tgvTest.png",
                  credits: 'moi - 2',
                  description: 'test test test test 2',
                ),
                MediaContent(
                  Path: "assets/press/travauxTest.png",
                  credits: 'moi - 3',
                  description: 'test test test test 3',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class IconButtonSvg extends StatelessWidget {
  final String path;
  final VoidCallback action;

  const IconButtonSvg({super.key, required this.path, required this.action});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(path, width: 32, height: 32),
      onPressed: action,
    );
  }
}
