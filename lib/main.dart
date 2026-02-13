import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
import 'core/herself_core.dart';

void main() async {
  // Ensure Flutter is ready before we do anything
  WidgetsFlutterBinding.ensureInitialized();
  
  // Pre-load the database so the app is instant
  final prefs = await SharedPreferences.getInstance();
  
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserState(prefs),
      child: const HerselfApp(),
    ),
  );
}

class HerselfApp extends StatelessWidget {
  const HerselfApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HERSELF',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF48FB1),
          primary: const Color(0xFFAD1457),
          secondary: const Color(0xFF00897B),
          surface: const Color(0xFFFFF8F9),
        ),
        // Poppins is beautiful, but we use system fallback to avoid wait times
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      home: const HomeScreen(),
    );
  }
}
