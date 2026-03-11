import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:lcdf_idfm/statsScreen/StatsScreen.dart';

class TrainStatsScreen extends StatsScreen {
  TrainStatsScreen({super.key, required super.title, required super.category});
  @override
  State<TrainStatsScreen> createState() => StateTrainStatsScreen();
}

class StateTrainStatsScreen extends StateStatsScreen<TrainStatsScreen> {
  @override
  late Excel file;

  @override
  String get excelPath => "assets/data/dataSpecs/StatsTrains.xlsx";

  StatsScreen getStatsScreen(String title, String category) {
    return TrainStatsScreen(title: title, category: category);
  }

  @override
  void excelDataCompletion(Excel file, String lineName) {
    Sheet sheet = file.tables.values.first;
    print("Feuille utilisée: ${sheet.sheetName}");

    for (var row in sheet.rows) {
      print(row.map((c) => c?.value).toList());
      String nameCell = row[0]?.value?.toString().trim() ?? "";
      if (nameCell == lineName) {
        print("Trouvé : $nameCell");
        widget.statistiquesWidget = Stats(
          statsMap: {
            "Nombre de rames : ": row[1]?.value?.toString() ?? "No data",
            "Nombre de voitures par rame : ":
                row[2]?.value?.toString() ?? "No data",
            "Nombre de niveaux : ": row[3]?.value?.toString() ?? "No data",
            "Nombre de places assises : ":
                row[4]?.value?.toString() ?? "No data",
            "Age moyen : ": row[5]?.value?.toString() ?? "No data",
          },
        );
        break;
      }
    }

    if (widget.statistiquesWidget == null) {
      widget.statistiquesWidget = Stats(
        statsMap: {"Erreur": "Aucune donnée trouvée pour $lineName"},
      );
    }
  }
}
