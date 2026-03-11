import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:lcdf_idfm/statsScreen/StatsScreen.dart';

class LineStatsScreen extends StatsScreen {
  LineStatsScreen({super.key, required super.title, required super.category});
  @override
  State<LineStatsScreen> createState() => StateLineStatsScreen();
}

class StateLineStatsScreen extends StateStatsScreen<LineStatsScreen> {
  @override
  late Excel file;

  @override
  String get excelPath => "assets/data/dataSpecs/StatsLignes.xlsx";

  @override
  void excelDataCompletion(Excel file, String lineName) {
    Sheet sheet = file.tables.values.first;

    for (var row in sheet.rows) {
      String nameCell = row[0]?.value?.toString().trim() ?? "";

      if (nameCell == lineName) {
        widget.statistiquesWidget = Stats(
          statsMap: {
            "Longueur : ": row[4]?.value?.toString() ?? "No data",
            "Nombre de stations : ": row[2]?.value?.toString() ?? "No data",
            "Materiel roulant : ": row[3]?.value?.toString() ?? "No data",
            "Trafic annuel : ": row[1]?.value?.toString() ?? "No data",
          },
        );
        break;
      }
    }
  }
}
