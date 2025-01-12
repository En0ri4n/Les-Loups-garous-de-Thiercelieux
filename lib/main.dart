import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const WerewolvesApp());
}

class WerewolvesApp extends StatelessWidget {
  const WerewolvesApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

