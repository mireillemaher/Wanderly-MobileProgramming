import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'sign_up_screen.dart';

// Start Screen
class StartScreen extends StatelessWidget {
  final VoidCallback onToggleTheme;

  const StartScreen({super.key, required this.onToggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: seedColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: Color(0xFFC8741A),
                child: Icon(Icons.landscape, size: 40, color: Colors.white),
              ),
              const SizedBox(height: 16),
              const Text(
                'Wanderly',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Explore the world, one cup at a time',
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ),
                  );
                },
                child: const Text('Start Exploring'),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: onToggleTheme,
                style: TextButton.styleFrom(foregroundColor: Colors.white),
                child: const Text('Toggle theme'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}