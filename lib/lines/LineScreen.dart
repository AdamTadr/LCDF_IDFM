import 'package:flutter/material.dart';
import 'package:lcdf_idfm/container/MediaContainer.dart';
import 'package:lcdf_idfm/lines/lineInfo/Mediatheque.dart';
import 'package:lcdf_idfm/selectionScreen/SelectionScreen.dart';
import 'package:lcdf_idfm/lines/lineInfo/LineStatsScreen.dart';
import 'package:lcdf_idfm/statsScreen/StatsScreen.dart';
import 'package:lcdf_idfm/lines/lineInfo/HistoryScreen.dart';
import 'package:lcdf_idfm/description/DescriptionLine.dart';
import 'package:lcdf_idfm/description/DescriptionScreen.dart';

class LineScreen extends SelectionScreen {
  const LineScreen({super.key}) : super(title: 'Les différentes lignes');

  @override
  State<LineScreen> createState() => LineScreenState();
}

class LineScreenState extends SelectionScreenState<LineScreen> {
  @override
  Map<String, String> get lineTitle => {
    "RER": "Les RERs",
    "Métro": "Les Métros",
    "Transilien": "Les Transiliens (Hors RER)",
    "Tramway": "Les Tramways",
  };

  @override
  StatsScreen getStatsScreen(String title, String category) {
    return LineStatsScreen(title: title, category: category);
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
    return DescriptionLine(
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
    categorizedDescriptions = {
      "Métro": await loadDescription(
        'assets/data/dataSpecs/dataDescriptions/metroDesc.json',
      ),
      "RER": await loadDescription(
        'assets/data/dataSpecs/dataDescriptions/rerDesc.json',
      ),
      "Transilien": await loadDescription(
        'assets/data/dataSpecs/dataDescriptions/transilienDesc.json',
      ),
      "Tramway": await loadDescription(
        'assets/data/dataSpecs/dataDescriptions/tramDesc.json',
      ),
    };

    final Map<String, MediaContainer> mapRer = await loadHistoryAndMedia(
      'assets/data/dataHistoryAndContent/rerHistAndCont.json',
    );
    final Map<String, MediaContainer> mapMetro = await loadHistoryAndMedia(
      'assets/data/dataHistoryAndContent/metroHistAndCont.json',
    );
    final Map<String, MediaContainer> mapTransilien = await loadHistoryAndMedia(
      'assets/data/dataHistoryAndContent/transilienHistAndCont.json',
    );
    final Map<String, MediaContainer> mapTram = await loadHistoryAndMedia(
      'assets/data/dataHistoryAndContent/tramHistAndCont.json',
    );

    allLineHistoryAndMedia = {
      ...mapRer,
      ...mapMetro,
      ...mapTransilien,
      ...mapTram,
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
    final List<String> prefixesLignes = ["RER", "Ligne"];

    for (final String prefix in prefixesLignes) {
      if (fileName.startsWith(prefix)) {
        return "Ligne ${fileName.replaceFirst(prefix, '')}";
      }
      if (fileName.startsWith("T")) {
        return "Ligne T${fileName.replaceFirst("T", '')}";
      }
    }
    return fileName;
  }
}
