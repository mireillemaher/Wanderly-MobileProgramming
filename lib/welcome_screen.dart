import 'package:flutter/material.dart';
import 'destinations_screen.dart';

// Task 5: Welcome Screen
class WelcomeScreen extends StatelessWidget {
  final String name;

  const WelcomeScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Color(0xFFE89A58),
                  child: Icon(Icons.timer, size: 40, color: Color(0xFF0F5A50)),
                ),
                const SizedBox(height: 24),
                Text(
                  'Welcome, $name!',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Your next trip starts here',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DestinationsScreen(),
                      ),
                    );
                  },
                  child: const Text('Browse Destinations'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}