import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FullScreenImage extends StatelessWidget {
  final String imagePath;
  final bool lightTheme;

  const FullScreenImage({required this.imagePath, this.lightTheme = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(backgroundColor : lightTheme ? Colors.white : Colors.black,
      iconTheme: IconThemeData(
      color: lightTheme ? Colors.black : Colors.white 
    ),),
      backgroundColor: lightTheme ? Colors.white : Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: InteractiveViewer(
            panEnabled: true,
            minScale: 1.0,
            maxScale: 4.0,  
            child: imagePath.split(".").last == "svg" ? SvgPicture.asset(imagePath) : Image.asset(imagePath),
          ),
        ),
      ),
    );
  }
}