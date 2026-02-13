import 'package:flutter/material.dart';

class GuardianScreen extends StatelessWidget {
  const GuardianScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Guardian')),
      body: const Center(
        child: Text('Emergency contacts and safety tools.'),
      ),
    );
  }
}
