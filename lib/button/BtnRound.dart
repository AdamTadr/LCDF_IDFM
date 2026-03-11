import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BtnRound extends StatelessWidget {
  final bool isUnactive;
  final double rotation;
  final VoidCallback action;

  const BtnRound({
    super.key,
    required this.isUnactive,
    required this.action,
    this.rotation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 25,
      height: 25,
      child: Opacity(
        opacity: isUnactive ? 0 : 0.70,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
          onPressed: action,
          child: Transform.rotate(
            angle: rotation,
            child: SvgPicture.asset(
              "assets/elements/btn.svg",
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
