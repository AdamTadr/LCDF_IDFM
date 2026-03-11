import 'package:flutter/material.dart';

class NameTitle extends StatelessWidget {
  final String title;

  const NameTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        title,
        style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 90, 90, 90)),
      ),
    );
  }
}
