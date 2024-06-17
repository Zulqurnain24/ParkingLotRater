import 'package:flutter/material.dart';
import 'package:parking_lot_rater/screens/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Parking-lot Rater',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.light(
              surface: Colors.grey.shade200,
              primary: const Color(0xFFFe3c72),
              onPrimary: Colors.black,
              secondary: const Color(0xFF424242),
              onSecondary: Colors.white,
              tertiary: const Color.fromRGBO(255, 204, 128, 1),
              error: Colors.red,
              outline: const Color(0xFF424242)
          ),
        ),
        home: const HomeScreen(),
    );
  }
}