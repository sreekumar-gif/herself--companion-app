import 'package:flutter/material.dart';

class SafeSpaceScreen extends StatefulWidget {
  const SafeSpaceScreen({super.key});

  @override
  State<SafeSpaceScreen> createState() => _SafeSpaceScreenState();
}

class _SafeSpaceScreenState extends State<SafeSpaceScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  String _status = 'Inhale';
  bool _isPlaying = true;

  @override
  void initState() {
    super.initState();
    // Box Breathing: 4s Inhale, 4s Hold, 4s Exhale, 4s Hold
    _controller = AnimationController(
      duration: const Duration(seconds: 16),
      vsync: this,
    )..repeat();

    _animation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 2.0).chain(CurveTween(curve: Curves.easeInOut)), weight: 25),
      TweenSequenceItem(tween: ConstantTween(2.0), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 2.0, end: 1.0).chain(CurveTween(curve: Curves.easeInOut)), weight: 25),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 25),
    ]).animate(_controller);

    _controller.addListener(() {
      double value = _controller.value;
      String newStatus = '';
      if (value < 0.25) {
        newStatus = 'Inhale';
      } else if (value < 0.50) {
        newStatus = 'Hold';
      } else if (value < 0.75) {
        newStatus = 'Exhale';
      } else {
        newStatus = 'Hold';
      }
      if (newStatus != _status) {
        setState(() => _status = newStatus);
      }
    });
  }

  void _togglePlay() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Safe Space')),
      floatingActionButton: FloatingActionButton(
        onPressed: _togglePlay,
        child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal[50]!, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Box Breathing',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            const SizedBox(height: 60),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _animation.value,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.teal.withOpacity(0.3),
                      border: Border.all(color: Colors.teal, width: 2),
                      boxShadow: [
                        if (_status == 'Hold')
                          BoxShadow(
                            color: Colors.teal.withOpacity(0.2),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                      ],
                    ),
                    child: Center(
                      child: Icon(Icons.spa, color: Colors.teal[700], size: 40),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 100),
            Text(
              _status,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: Colors.teal[800],
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Box breathing technique to calm your nervous system.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
