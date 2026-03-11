import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lcdf_idfm/text/CategoryTitle.dart';
import 'package:lcdf_idfm/text/NameTitle.dart';

class LineBtn extends StatelessWidget {
  final String logoPath;
  final String categorie;
  final String ligne;
  final bool bigScreen;
  final Widget descriptionScreen;

  const LineBtn({
    super.key,
    required this.logoPath,
    required this.categorie,
    required this.ligne,
    required this.bigScreen,
    required this.descriptionScreen,
  });

  Widget assetImage(String path) {
    if (path.endsWith('.png') || path.endsWith('.jpg')) {
      return Column(
        children: [
          Container(
            width: bigScreen ? 100 : 80,
            height: bigScreen ? 100 : 80,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(path, fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: bigScreen ? 0 : 8),
          if (!bigScreen) NameTitle(title: ligne),
        ],
      );
    }

    return SvgPicture.asset(
      path,
      width: bigScreen ? 100 : 60,
      height: bigScreen ? 100 : 60,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: bigScreen ? const EdgeInsets.all(10) : const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => descriptionScreen),
              );
            },
            child: assetImage(logoPath),
          ),
          if (bigScreen) ...[
            const SizedBox(height: 15),
            CategoryTitle(title: categorie),
            NameTitle(title: ligne),
          ],
        ],
      ),
    );
  }
}
