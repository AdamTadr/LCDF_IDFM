import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:lcdf_idfm/button/btnRound.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:lcdf_idfm/text/MainTitle.dart';
import 'package:lcdf_idfm/text/SubTitle.dart';

abstract class StatsScreen extends StatefulWidget {
  String title;
  String category;
  Stats? statistiquesWidget;
  StatsScreen({super.key, required this.title, required this.category});
}

abstract class StateStatsScreen<T extends StatsScreen> extends State<T> {
  late Excel file;
  String get excelPath;

  void excelDataCompletion(Excel file, String lineName);

  Future<Excel> loadExcel(String assetPath) async {
    final data = await rootBundle.load(assetPath);
    final bytes = data.buffer.asUint8List();
    final excel = Excel.decodeBytes(bytes);
    return excel;
  }

  void initExcelStats(Future<Excel> futureExcel) async {
    file = await futureExcel;
    excelDataCompletion(file, widget.title);
    if (!mounted) return;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initExcelStats(loadExcel(excelPath));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 110,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            MainTitle(title: "Statistiques - ${widget.title}"),
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
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [widget.statistiquesWidget ?? CircularProgressIndicator()],
        ),
      ),
    );
  }
}

class Stats extends StatelessWidget {
  Map<String, String> statsMap;

  Stats({super.key, required this.statsMap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: statsMap.entries.map((entry) {
        return Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: Row(
            children: [
              Text(entry.key, style: TextStyle(fontSize: 20)),
              SubTitle(title: entry.value),
            ],
          ),
        );
      }).toList(),
    );
  }
}
