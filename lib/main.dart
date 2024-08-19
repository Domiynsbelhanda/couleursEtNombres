import 'package:couleursetnombres/pages/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Brandon',
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: 'Brandon', fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontFamily: 'Brandon', fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(fontFamily: 'Brandon'),
          bodyMedium: TextStyle(fontFamily: 'Brandon'),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
