import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/herself_core.dart';
import 'dart:async';

class GuardianScreen extends StatefulWidget {
  const GuardianScreen({super.key});

  @override
  State<GuardianScreen> createState() => _GuardianScreenState();
}

class _GuardianScreenState extends State<GuardianScreen> {
  bool _isCountdownActive = false;
  int _countdown = 5;
  Timer? _timer;

  void _startCountdown() {
    setState(() {
      _isCountdownActive = true;
      _countdown = 5;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_countdown > 1) {
        setState(() => _countdown--);
      } else {
        timer.cancel();
        setState(() {
          _isCountdownActive = false;
        });
        if (mounted) {
          _showSOSSent();
        }
      }
    });
  }

  void _cancelCountdown() {
    _timer?.cancel();
    setState(() {
      _isCountdownActive = false;
    });
  }

  void _showSOSSent() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('SOS Alert Sent to Emergency Contacts!'),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _editContacts(BuildContext context, UserState state) {
    final controller = TextEditingController(text: state.emergencyContacts);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Emergency Contacts'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'e.g., Mom, Dad, Police'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              state.updateEmergencyContacts(controller.text);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserState>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Guardian Safety')),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                _buildSafetyCard(
                  'Emergency Contacts',
                  userState.emergencyContacts,
                  Icons.people,
                  Colors.indigo,
                  () => _editContacts(context, userState),
                ),
                const SizedBox(height: 20),
                _buildSafetyCard(
                  'Current Location',
                  userState.isSharingLocation ? 'Sharing active with contacts' : 'Location sharing paused',
                  Icons.location_on,
                  userState.isSharingLocation ? Colors.green : Colors.grey,
                  () => userState.toggleLocation(),
                  trailing: Switch(
                    value: userState.isSharingLocation,
                    onChanged: (val) => userState.toggleLocation(),
                  ),
                ),
                const Spacer(),
                const Text(
                  'Press and hold for 2 seconds for SOS',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onLongPress: _startCountdown,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.4),
                          blurRadius: 20,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'SOS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
          if (_isCountdownActive)
            Container(
              color: Colors.black87,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sending SOS in...',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '$_countdown',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: _cancelCountdown,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                      child: const Text('CANCEL', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSafetyCard(String title, String subtitle, IconData icon, Color color, VoidCallback onTap, {Widget? trailing}) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: color),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: trailing ?? const Icon(Icons.edit, size: 16),
      ),
    );
  }
}
