import 'package:flutter/material.dart';

class MainTitle extends StatelessWidget {
  final String title;

  const MainTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
      softWrap: true,
      overflow: TextOverflow.visible,
    );
  }
}
