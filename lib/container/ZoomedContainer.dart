import 'package:flutter/material.dart';
import 'package:lcdf_idfm/button/BtnRound.dart';
import 'package:lcdf_idfm/text/MainTitle.dart';

class ZoomedContainer extends StatefulWidget {
  final int nbElementRow;
  final List<Widget> elements;
  final String title;
  ZoomedContainer({
    super.key,
    required this.elements,
    required this.nbElementRow,
    required this.title,
  }) : assert(nbElementRow > 0, "nbElementRow doit être supérieur à 0"),
       assert(elements.isNotEmpty, "La liste d'éléments ne peut pas être vide"),
       assert(title.isNotEmpty, "Le title ne peut pas être vide");

  @override
  State<ZoomedContainer> createState() => _ZoomedLineContainerState();
}

class _ZoomedLineContainerState extends State<ZoomedContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            MainTitle(title: widget.title),
            const SizedBox(width: 10),
            BtnRound(
              rotation: 3.14,
              isUnactive: false,
              action: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        centerTitle: false,
        toolbarHeight: 110,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (
                int i = 0;
                i < widget.elements.length / widget.nbElementRow.ceil();
                i++
              ) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: widget.elements
                      .skip(i * widget.nbElementRow)
                      .take(widget.nbElementRow)
                      .map((element) {
                        return element;
                      })
                      .toList(),
                ),
                const SizedBox(height: 20),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
