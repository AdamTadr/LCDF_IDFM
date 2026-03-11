import 'package:flutter/material.dart';
import 'package:lcdf_idfm/mail/MailWidget.dart';
import 'package:lcdf_idfm/principals/NavBar.dart';
import 'package:lcdf_idfm/principals/HomeScreen.dart';
import 'package:lcdf_idfm/lines/LineScreen.dart';
import 'package:lcdf_idfm/trains/TrainScreen.dart';

void main() {
  runApp(MonApp());
}

class MonApp extends StatefulWidget {
  const MonApp({super.key});

  @override
  State<MonApp> createState() => _MonAppState();
}

class _MonAppState extends State<MonApp> {
  final ValueNotifier<int> index = ValueNotifier(0);

  final pages = [HomeScreen(), LineScreen(), TrainScreen(), MailWidget()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LeCompagnon-IDF',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 255, 255, 255),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: ValueListenableBuilder(
          valueListenable: index,
          builder: (context, index, _) {
            return AnimatedSwitcher(
              transitionBuilder: (child, animation) {
                final offsetAnimation = Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation);

                return SlideTransition(
                  position: offsetAnimation,
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              duration: const Duration(milliseconds: 150),
              child: pages[index],
            );
          },
        ),
        bottomNavigationBar: NavBar(index: index),
      ),
    );
  }
}
