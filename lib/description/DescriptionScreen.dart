import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lcdf_idfm/button/TextBtn.dart';
import 'package:lcdf_idfm/button/btnRound.dart';
import 'package:lcdf_idfm/lines/lineInfo/HistoryScreen.dart';
import 'package:lcdf_idfm/lines/lineInfo/Mediatheque.dart';
import 'package:lcdf_idfm/text/MainTitle.dart';

abstract class DescriptionScreen extends StatefulWidget {
  final String title;
  final String category;
  final String description;
  final String imagePath;
  final HistoryScreen historyScreen;
  final Mediatheque mediatheque;

  const DescriptionScreen({
    super.key,
    required this.category,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.historyScreen,
    required this.mediatheque,
  });
}

abstract class DescriptionScreenState<T extends DescriptionScreen>
    extends State<T> {
  Widget customBtnRow(BuildContext context, String imagePath);

  Widget assetImage(String path) {
    if (path.endsWith('.png') || path.endsWith('.jpg')) {
      return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(path, fit: BoxFit.cover),
        ),
      );
    }

    return SvgPicture.asset(path, width: 60, height: 60);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 110,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            MainTitle(title: "La ${widget.title}"),
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
      body: Padding(
        padding: const EdgeInsets.only(right: 15, left: 15, bottom: 80),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  assetImage(widget.imagePath),
                  const SizedBox(width: 10),
                  MainTitle(title: widget.title),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  widget.description,
                  style: TextStyle(
                    fontSize: 19,
                    color: Color.fromARGB(255, 90, 90, 90),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextBtn(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => widget.mediatheque,
                        ),
                      );
                    },
                    text: 'Médiathèque ',
                  ),
                  SizedBox(width: 20),
                  TextBtn(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => widget.historyScreen,
                        ),
                      );
                    },
                    text: 'Histoire',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              customBtnRow(context, widget.imagePath),
            ],
          ),
        ),
      ),
    );
  }
}
