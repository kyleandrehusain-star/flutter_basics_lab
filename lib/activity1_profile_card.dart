// Activity 1: Your first screen with StatelessWidgets
import 'package:flutter/material.dart';
import 'student.dart';

void main() {
  runApp(const ProfileApp());
}

// 1. The root of the app: a StatelessWidget that sets up MaterialApp
class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity 1',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: studentColor),
      home: Scaffold(
        appBar: AppBar(title: const Text('Activity 1 - $studentName')),
        body: const Center(child: ProfileCard()),
      ),
    );
  }
}

// 2. A reusable card that never changes after it is drawn
class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.all(24),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: colors.primary,
              child: Icon(Icons.person, size: 56, color: colors.onPrimary),
            ),
            const SizedBox(height: 16),
            const Text(
              'Kyle Andre S. Husain', // <-- change to your full name
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'BS Information Technology', // <-- change to your program
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.email, size: 20),
                SizedBox(width: 8),
                Text('kyleandre.husain@csucc.edu.ph'), // <-- change to your email
              ],
            ),
            // Task 2: below the email Row, a second Row with Icons.phone and
            // a contact number, separated by a SizedBox(height: 8).
            const SizedBox(height: 8),
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.phone, size: 20),
                SizedBox(width: 8),
                Text('0948 526 3970'), // your contact number
              ],
            ),
          ],
        ),
      ),
    );
  }
}
