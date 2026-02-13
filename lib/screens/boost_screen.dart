import 'package:flutter/material.dart';

class BoostScreen extends StatelessWidget {
  const BoostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Boost')),
      body: const Center(
        child: Text('Self-Care & Motivation Boosters!'),
      ),
    );
  }
}
