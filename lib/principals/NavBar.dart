import 'package:flutter/material.dart';
import 'package:lcdf_idfm/principals/HomeScreen.dart';

class NavBar extends StatelessWidget {
  final ValueNotifier<int> index;
  const NavBar({super.key, Key? key, required this.index});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(color: Colors.grey, thickness: 1, height: 8),
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButtonSvg(
                  path: "assets/appBarLogo/trains.svg",
                  action: () {
                    index.value = 2;
                  },
                ),
                IconButtonSvg(
                  path: "assets/appBarLogo/A.svg",
                  action: () {
                    index.value = 1;
                  },
                ),
                IconButtonSvg(
                  path: "assets/appBarLogo/home.svg",
                  action: () {
                    index.value = 0;
                  },
                ),
                IconButtonSvg(
                  path: "assets/appBarLogo/heart.svg",
                  action: () {
                    index.value = 3;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
