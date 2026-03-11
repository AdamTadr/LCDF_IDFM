import 'package:flutter/material.dart';
import 'package:lcdf_idfm/container/ZoomedContainer.dart';
import 'package:lcdf_idfm/text/SubTitle.dart';
import 'package:lcdf_idfm/button/BtnRound.dart';
import 'package:lcdf_idfm/button/LineBtn.dart';

class Linecontainer extends StatefulWidget {
  final List<LineBtn> elements;
  final String title;
  const Linecontainer({super.key, required this.elements, required this.title});
  @override
  State<Linecontainer> createState() => _LinecontainerState();
}

class _LinecontainerState extends State<Linecontainer> {
  late final Widget zoomedLineContainer;

  @override
  void initState() {
    super.initState();
    zoomedLineContainer = ZoomedContainer(
      elements: widget.elements.map((elemt) {
        return LineBtn(
          logoPath: elemt.logoPath,
          categorie: elemt.categorie,
          ligne: elemt.ligne,
          bigScreen: true,
          descriptionScreen: elemt.descriptionScreen,
        );
      }).toList(),
      title: widget.title,
      nbElementRow: 3,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Row(
            children: [
              SubTitle(title: widget.title),
              const SizedBox(width: 10),
              BtnRound(
                rotation: 0,
                isUnactive: false,
                action: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => zoomedLineContainer,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: widget.elements.map((element) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: LineBtn(
                  logoPath: element.logoPath,
                  categorie: element.categorie,
                  ligne: element.ligne,
                  bigScreen: false,
                  descriptionScreen: element.descriptionScreen,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
