import 'package:flutter/material.dart';

class DailyPlannerScreen extends StatelessWidget {
  const DailyPlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daily Planner')),
      body: const Center(
        child: Text('Organize your day and tasks.'),
      ),
    );
  }
}
