import 'package:flutter/material.dart';
import 'package:lcdf_idfm/description/DescriptionScreen.dart';
import 'package:lcdf_idfm/button/TextBtn.dart';
import 'package:lcdf_idfm/principals/FullScreenImage.dart';
import 'package:lcdf_idfm/lines/lineInfo/LineStatsScreen.dart';

class DescriptionLine extends DescriptionScreen {
  const DescriptionLine({
    super.key,
    required super.category,
    required super.title,
    required super.description,
    required super.imagePath,
    required super.historyScreen,
    required super.mediatheque,
  });

  @override
  State<DescriptionLine> createState() => _DescriptionLineState();
}

class _DescriptionLineState extends DescriptionScreenState<DescriptionLine> {
  @override
  Widget customBtnRow(BuildContext context, String imagePath) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextBtn(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FullScreenImage(
                  imagePath: 'assets/content/images/RERTEST/PlanRerA.svg',
                  lightTheme: true,
                ),
              ),
            );
          },
          text: 'Afficher carte',
        ),
        const SizedBox(width: 20),
        TextBtn(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => LineStatsScreen(
                  title: widget.title,
                  category: widget.category,
                ),
              ),
            );
          },
          text: 'Afficher stats.',
        ),
      ],
    );
  }
}
