// Activity 3: Basic layouts with Container, Row, Column and Expanded
import 'package:flutter/material.dart';
import 'student.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity 3',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: studentColor),
      home: const WeatherPage(),
    );
  }
}

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Activity 3 - $studentName')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Header: a colored Container with a Row inside
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colors.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(Icons.wb_sunny, size: 64, color: colors.onPrimary),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cabadbaran City', // <-- change to your hometown
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: colors.onPrimary,
                          ),
                        ),
                        Text(
                          'Sunny, 31°C',
                          style: TextStyle(fontSize: 18, color: colors.onPrimary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 2. Four boxes that share the width equally (Expanded)
            const Row(
              children: [
                Expanded(
                  child: StatBox(icon: Icons.water_drop, label: 'Humidity', value: '70%'),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: StatBox(icon: Icons.air, label: 'Wind', value: '12 km/h'),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: StatBox(icon: Icons.umbrella, label: 'Rain', value: '10%'),
                ),
                // <-- fourth box added, with its own SizedBox(width: 12)
                SizedBox(width: 12),
                Expanded(
                  child: StatBox(
                    icon: Icons.thermostat,
                    label: 'Feels like',
                    value: '35°',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 3. Hourly forecast spread across the row (spaceBetween)
            const Text(
              'Next hours',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HourForecast(time: '1 PM', icon: Icons.wb_sunny, temp: '32°'),
                HourForecast(time: '2 PM', icon: Icons.wb_cloudy, temp: '31°'),
                HourForecast(time: '3 PM', icon: Icons.thunderstorm, temp: '28°'),
                HourForecast(time: '4 PM', icon: Icons.cloud, temp: '27°'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// A small reusable box: data comes in through the constructor
class StatBox extends StatelessWidget {
  const StatBox({super.key, required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: colors.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: colors.primary),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(label),
        ],
      ),
    );
  }
}

class HourForecast extends StatelessWidget {
  const HourForecast({super.key, required this.time, required this.icon, required this.temp});

  final String time;
  final IconData icon;
  final String temp;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(time),
        const SizedBox(height: 6),
        Icon(icon, size: 32),
        const SizedBox(height: 6),
        Text(temp, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
