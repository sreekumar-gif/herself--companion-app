import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(const HerselfApp());
}

class HerselfApp extends StatelessWidget {
  const HerselfApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HERSELF',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
