import 'package:flutter/material.dart';

class CategoryTitle extends StatelessWidget {
  final String title;

  const CategoryTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14,
          color: const Color.fromARGB(255, 79, 79, 79),
        ),
      ),
    );
  }
}
