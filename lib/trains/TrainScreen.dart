import 'package:flutter/material.dart';
import 'package:lcdf_idfm/container/MediaContainer.dart';
import 'package:lcdf_idfm/description/DescriptionScreen.dart';
import 'package:lcdf_idfm/lines/lineInfo/Mediatheque.dart';
import 'package:lcdf_idfm/selectionScreen/SelectionScreen.dart';
import 'package:lcdf_idfm/trains/TrainStatsScreen.dart';
import 'package:lcdf_idfm/statsScreen/StatsScreen.dart';
import 'package:lcdf_idfm/description/DescriptionTrain.dart';
import 'package:lcdf_idfm/lines/lineInfo/HistoryScreen.dart';

class TrainScreen extends SelectionScreen {
  const TrainScreen({super.key})
    : super(title: 'Les différents modèles de trains');

  @override
  State<TrainScreen> createState() => TrainScreenState();
}

class TrainScreenState extends SelectionScreenState<TrainScreen> {
  @override
  Map<String, String> get lineTitle => {
    "RER": "Les Rames du RER",
    "Métro": "Les Métros",
    "Train": "Les Trains transilien (Hors RER)",
    "Tramway": "Les Tramways",
    "RATP": "Les Trains RATP",
    "SNCF": "Les Trains SNCF",
    "Z2N": "Les Z2N",
  };

  @override
  StatsScreen getStatsScreen(String title, String category) {
    return TrainStatsScreen(title: title, category: category);
  }

  @override
  DescriptionScreen getDescriptionScreen({
    required String title,
    required String category,
    required String description,
    required String imagePath,
    required MediaContainer mediaContainer,
    required HistoryScreen historyScreen,
  }) {
    return DescriptionTrain(
      title: title,
      category: category,
      description: description,
      imagePath: imagePath,
      historyScreen: historyScreen,
      mediatheque: Mediatheque(title: title, media: mediaContainer),
    );
  }

  @override
  void initDescriptions() async {
    List<Map<String, String>> trainsModelDescription = await loadDescription(
      'assets/data/dataSpecs/dataDescriptions/trainModelDesc.json',
    );

    final Map<String, MediaContainer> mapTrainsModel =
        await loadHistoryAndMedia(
          'assets/data/dataHistoryAndContent/trainModelHistAndCont.json',
        );

    allLineHistoryAndMedia = mapTrainsModel;

    categorizedDescriptions = {
      "RER": trainsModelDescription
          .where(
            (e) =>
                e['logo']!.contains('Z') ||
                e['logo']!.contains('MI') ||
                e['logo']!.contains('MS'),
          )
          .toList(),
      "Métro": trainsModelDescription
          .where((e) => e['logo']!.contains('MF') || e['logo']!.contains('MP'))
          .toList(),
      "Train": trainsModelDescription
          .where(
            (e) =>
                e['logo']!.contains('Z') ||
                e['logo']!.contains('B') ||
                e['logo']!.contains('VB2N'),
          )
          .toList(),
      "Tramway": trainsModelDescription
          .where(
            (e) =>
                e['logo']!.contains('Translohr') ||
                e['logo']!.contains('Citadis') ||
                e['logo']!.contains('U') ||
                e['logo']!.contains('TFS') ||
                e['logo']!.contains('Avento'),
          )
          .toList(),
      "RATP": trainsModelDescription
          .where(
            (e) =>
                e['logo']!.contains('Translohr') ||
                e['logo']!.contains('Citadis3') ||
                e['logo']!.contains('Citadis4') ||
                e['logo']!.contains('U') ||
                e['logo']!.contains('MF') ||
                e['logo']!.contains('MP') ||
                e['logo']!.contains('MI') ||
                e['logo']!.contains('MS') ||
                e['logo']!.contains('TW20') ||
                e['logo']!.contains('TFS'),
          )
          .toList(),
      "SNCF": trainsModelDescription
          .where(
            (e) =>
                e['logo']!.contains('Z') ||
                e['logo']!.contains('B') ||
                e['logo']!.contains('VB2N') ||
                e['logo']!.contains('Translohr') ||
                e['logo']!.contains('CitadisDualis') ||
                e['logo']!.contains('Avento'),
          )
          .toList(),
      "Z2N": trainsModelDescription
          .where(
            (e) =>
                e['logo']!.contains('Z20') ||
                e['logo']!.contains('Z5600') ||
                e['logo']!.contains('Z8800'),
          )
          .toList(),
    };

    lineContainers = LineContainerBuilder(
      categorizedDescriptions,
      allLineHistoryAndMedia,
      lineTitle,
    );

    setState(() {});
  }

  @override
  String extractName(String path) {
    String fileName = path.split('/').last.split('.').first;

    final List<String> prefixesTrains = [
      "Z",
      "B",
      "MI",
      "MS",
      "(RER NG)",
      "(REGIO2N)",
      "(Z2N)",
      "MF",
      "MP",
      "Citadis",
      "Translohr",
      "U",
    ];

    for (final String prefix in prefixesTrains) {
      if (fileName.startsWith(prefix)) {
        return fileName.replaceFirst(prefix, '$prefix ');
      }
    }

    return fileName;
  }
}
