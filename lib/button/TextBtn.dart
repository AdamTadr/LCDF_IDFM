import 'package:flutter/material.dart';

class TextBtn extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const TextBtn({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 150,
        height: 50,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 226, 226, 226),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center (
          child : Padding(
          padding: const EdgeInsets.only(right: 5, left: 5),
          child: Text(
            text,
            style: TextStyle(
              color: const Color.fromARGB(255, 28, 28, 28),
              fontSize: 18,
            ),
          ),
        ),
        ),
      ),
    );
  }
}
