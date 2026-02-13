import 'package:flutter/material.dart';
import 'screens/boost_screen.dart';
import 'screens/safe_space_screen.dart';
import 'screens/daily_planner_screen.dart';
import 'screens/health_care_screen.dart';
import 'screens/guardian_screen.dart';
import 'core/herself_core.dart';

// 1. Changed to StatefulWidget so we can update the UI when the user picks a mood/energy
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 2. State variables for simulation
  String _mood = 'stressed';
  int _energyLevel = 4;
  final String _dayStatus = 'pending tasks';

  @override
  Widget build(BuildContext context) {
    // 3. Create the logic instance with current state values
    final core = HerselfCore(
      mood: _mood,
      energyLevel: _energyLevel,
      dayStatus: _dayStatus,
    );

    // 4. Get the recommendation based on current state
    String suggestedModule = core.getSuggestedModule();

    return Scaffold(
      appBar: AppBar(
        title: const Text('HERSELF'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome, Sreeharini!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // --- ADDED: SIMULATION DROPDOWNS ---
            Row(
              children: [
                // Mood Dropdown
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('How is your mood?', style: TextStyle(fontSize: 12)),
                      DropdownButton<String>(
                        value: _mood,
                        isExpanded: true,
                        items: ['happy', 'stressed', 'tired'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _mood = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                // Energy Level Dropdown
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Energy Level (1-10)', style: TextStyle(fontSize: 12)),
                      DropdownButton<int>(
                        value: _energyLevel,
                        isExpanded: true,
                        items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(value.toString()),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _energyLevel = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),

            // Recommendation Banner
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.pinkAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.pinkAccent),
              ),
              child: Row(
                children: [
                  const Icon(Icons.lightbulb, color: Colors.pinkAccent),
                  const SizedBox(width: 10),
                  Text(
                    'Recommended for you: $suggestedModule',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.pinkAccent,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [
                  _buildDashboardButton(
                    context,
                    'Boost',
                    Icons.bolt,
                    Colors.orange,
                    const BoostScreen(),
                    suggestedModule == 'Boost',
                  ),
                  _buildDashboardButton(
                    context,
                    'Safe Space',
                    Icons.spa,
                    Colors.teal,
                    const SafeSpaceScreen(),
                    suggestedModule == 'Safe Space',
                  ),
                  _buildDashboardButton(
                    context,
                    'Daily Planner',
                    Icons.event_note,
                    Colors.blue,
                    const DailyPlannerScreen(),
                    suggestedModule == 'Daily Planner',
                  ),
                  _buildDashboardButton(
                    context,
                    'Health Care',
                    Icons.favorite,
                    Colors.redAccent,
                    const HealthCareScreen(),
                    suggestedModule == 'Health Care',
                  ),
                  _buildDashboardButton(
                    context,
                    'Guardian',
                    Icons.security,
                    Colors.indigo,
                    const GuardianScreen(),
                    suggestedModule == 'Guardian',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardButton(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    Widget targetScreen,
    bool isSuggested,
  ) {
    Color displayColor = isSuggested ? Colors.pinkAccent : color;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetScreen),
        );
      },
      child: Card(
        color: displayColor.withOpacity(0.1),
        elevation: isSuggested ? 4 : 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: displayColor,
            width: isSuggested ? 4 : 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: displayColor),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: displayColor,
              ),
            ),
            if (isSuggested)
              const Text(
                'Suggested',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.pinkAccent,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
