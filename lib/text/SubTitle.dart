import 'package:flutter/material.dart';

class SubTitle extends StatelessWidget {
  final String title;

  const SubTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      softWrap: true,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 19,
        color: Colors.black,
      ),
    );
  }
}
