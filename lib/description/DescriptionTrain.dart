import 'package:flutter/material.dart';
import 'package:lcdf_idfm/description/DescriptionScreen.dart';
import 'package:lcdf_idfm/button/TextBtn.dart';
import 'package:lcdf_idfm/trains/TrainStatsScreen.dart';

class DescriptionTrain extends DescriptionScreen {
  const DescriptionTrain({
    super.key,
    required super.category,
    required super.title,
    required super.description,
    required super.imagePath,
    required super.historyScreen,
    required super.mediatheque,
  });

  @override
  State<DescriptionTrain> createState() => _DescriptionTrainState();
}

class _DescriptionTrainState extends DescriptionScreenState<DescriptionTrain> {
  @override
  Widget customBtnRow(BuildContext context, String imagePath) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextBtn(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TrainStatsScreen(
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
