import 'package:flutter/material.dart';

class SafeSpaceScreen extends StatelessWidget {
  const SafeSpaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Safe Space')),
      body: const Center(
        child: Text('A peaceful place for your thoughts.'),
      ),
    );
  }
}
