import 'package:flutter/material.dart';
import 'package:lcdf_idfm/container/MediaContainer.dart';
import 'package:lcdf_idfm/description/DescriptionScreen.dart';
import 'package:lcdf_idfm/lines/lineInfo/HistoryScreen.dart';
import 'package:lcdf_idfm/statsScreen/StatsScreen.dart';
import 'package:lcdf_idfm/text/MainTitle.dart';
import 'package:lcdf_idfm/button/LineBtn.dart';
import 'package:lcdf_idfm/container/line/LineContainer.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

abstract class SelectionScreen extends StatefulWidget {
  final String title;
  const SelectionScreen({super.key, required this.title});
}

abstract class SelectionScreenState<T extends SelectionScreen>
    extends State<T> {
  Map<String, String> get lineTitle;

  Map<String, List<Map<String, String>>>? categorizedDescriptions;
  Map<String, MediaContainer>? allLineHistoryAndMedia;
  List<Widget>? lineContainers;

  void initDescriptions() async {
    // Les enfants doivent définir leur propre logique ici
  }

  @override
  void initState() {
    super.initState();
    initDescriptions();
  }

  Future<List<Map<String, String>>> loadDescription(String file) async {
    final String jsonString = await rootBundle.loadString(file);

    final List<dynamic> jsonList = json.decode(jsonString);

    return jsonList.map<Map<String, String>>((item) {
      return {
        'logo': item['logo'] as String,
        'description': item['description'] as String,
      };
    }).toList();
  }

  StatsScreen getStatsScreen(String title, String category);

  DescriptionScreen getDescriptionScreen({
    required String title,
    required String category,
    required String description,
    required String imagePath,
    required MediaContainer mediaContainer,
    required HistoryScreen historyScreen,
  });

  List<Widget> LineContainerBuilder(
    Map<String, List<Map<String, String>>>? CategorizedDescriptions,
    Map<String, MediaContainer>? historyAndMedia,
    Map<String, String> titlesList,
  ) {
    return titlesList.entries.map((entry) {
      List<Map<String, String>>? descriptions =
          CategorizedDescriptions?[entry.key];
      return Column(
        children: [
          Linecontainer(
            title: entry.value,
            elements: descriptions!.map((line) {
              return LineBtn(
                logoPath: line['logo']!,
                categorie: entry.key,
                ligne: extractName(line['logo']!),
                bigScreen: false,
                descriptionScreen: getDescriptionScreen(
                  title: extractName(line['logo']!),
                  description: line['description']!,
                  imagePath: line['logo']!,
                  category: entry.key,
                  mediaContainer:
                      historyAndMedia![extractName(line['logo']!)] ??
                      MediaContainer(
                        ParagrHist: [],
                        images: [],
                        sons: [],
                        videos: [],
                      ),
                  historyScreen: HistoryScreen(
                    mediaContainers:
                        historyAndMedia[extractName(line['logo']!)] ??
                        MediaContainer(
                          ParagrHist: [],
                          images: [],
                          sons: [],
                          videos: [],
                        ),
                    title: extractName(line['logo']!),
                    Category: entry.key,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 13),
        ],
      );
    }).toList();
  }

  Future<Map<String, MediaContainer>> loadHistoryAndMedia(String file) async {
    final String jsonString = await rootBundle.loadString(file);

    final List<dynamic> jsonList = json.decode(jsonString);

    final Map<String, dynamic> rawData = jsonList.first as Map<String, dynamic>;

    final Map<String, Map<String, dynamic>> dataEntry = rawData.map(
      (key, value) => MapEntry(key, value as Map<String, dynamic>),
    );

    final Map<String, MediaContainer> result = dataEntry.map(
      (key, value) => MapEntry(
        key,
        MediaContainer(
          ParagrHist: List<String>.from(
            value['ParagrHist'] as List<dynamic>,
          ).cast<String>(),
          images: (value['images'] as List<dynamic>).map((e) {
            return MediaContent(
              Path: e['Path'] as String,
              credits: e['credits'] as String,
              description: e['description'] as String,
            );
          }).toList(),
          sons: (value['sons'] as List<dynamic>).map((e) {
            return MediaContent(
              Path: e['Path'] as String,
              credits: e['credits'] as String,
              description: e['description'] as String,
            );
          }).toList(),
          videos: (value['videos'] as List<dynamic>).map((e) {
            return MediaContent(
              Path: e['Path'] as String,
              credits: e['credits'] as String,
              description: e['description'] as String,
            );
          }).toList(),
        ),
      ),
    );

    return result;
  }

  String extractName(String path);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MainTitle(title: widget.title),
        centerTitle: false,
        toolbarHeight: 110,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: lineContainers == null
              ? Center(child: CircularProgressIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: lineContainers!,
                ),
        ),
      ),
    );
  }
}
