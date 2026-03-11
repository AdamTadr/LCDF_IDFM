import 'package:flutter/material.dart';

class DescriptionText extends StatelessWidget {
  final String text;

  const DescriptionText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 16,
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    );
  }
}
