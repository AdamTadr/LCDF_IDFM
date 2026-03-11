import 'package:flutter/material.dart';
import 'package:lcdf_idfm/text/DescriptionText.dart';

class TextZone extends StatelessWidget {
  final String text;

  const TextZone({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.only(right: 20, left: 20, bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(10),
            child: DescriptionText(text: text),
          ),
        ],
      ),
    );
  }
}
