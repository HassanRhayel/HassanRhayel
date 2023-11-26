import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const FlagGuessApp());
}

class FlagGuessApp extends StatelessWidget {
  const FlagGuessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guess The Flag App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

