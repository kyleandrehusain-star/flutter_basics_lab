import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';import 'package:flutter_basics_lab/activity1_profile_card.dart';
import 'package:flutter_basics_lab/activity2_water_tracker.dart';
import 'package:flutter_basics_lab/activity3_weather_layout.dart';
import 'package:flutter_basics_lab/activity4_cafe_menu.dart';
import 'package:flutter_basics_lab/activity5_theme_components.dart';
import 'package:flutter_basics_lab/student.dart';

void main() {
  group('Activity 1 - Profile Card', () {
    testWidgets('App loads smoke test', (WidgetTester tester) async {
      await tester.pumpWidget(const ProfileApp());
    });

    testWidgets('Title bar shows Activity 1 and the student name', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ProfileApp());

      expect(find.text('Activity 1 - $studentName'), findsOneWidget);
    });

    testWidgets('Profile card shows the student details', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ProfileApp());

      expect(find.text('Kyle Andre S. Husain'), findsOneWidget);
      expect(find.text('BS Information Technology'), findsOneWidget);
      expect(find.text('kyleandre.husain@csucc.edu.ph'), findsOneWidget);
      expect(find.text('0948 526 3970'), findsOneWidget);
    });

    testWidgets('Card lays out without overflow on a browser window', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ProfileApp());

      expect(tester.takeException(), isNull);
      expect(find.byType(ProfileCard), findsOneWidget);
    });
  });

  group('Activity 2 - Water Tracker', () {
    testWidgets('Starts at 0 glasses with the goal of 6', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const WaterTrackerApp());

      expect(find.text('0 / 6 glasses'), findsOneWidget);
      expect(find.text('Keep drinking water!'), findsOneWidget);
      expect(find.text('Activity 2 - $studentName'), findsOneWidget);
    });

    testWidgets('Tapping + raises the count and reaches the goal', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const WaterTrackerApp());

      for (var i = 0; i < 6; i++) {
        await tester.tap(find.byIcon(Icons.add));
        await tester.pump();
      }

      expect(find.text('6 / 6 glasses'), findsOneWidget);
      expect(find.text('nice job pi'), findsOneWidget);
    });

    testWidgets('Tapping - lowers the count and Reset clears it', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const WaterTrackerApp());

      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(find.text('1 / 6 glasses'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();
      expect(find.text('0 / 6 glasses'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      await tester.tap(find.text('Reset'));
      await tester.pump();
      expect(find.text('0 / 6 glasses'), findsOneWidget);
    });
  });

  group('Activity 3 - Weather Dashboard', () {
    testWidgets('Shows the hometown, four stat boxes and the forecast', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const WeatherApp());

      expect(find.text('Activity 3 - $studentName'), findsOneWidget);
      expect(find.text('Cabadbaran City'), findsOneWidget);
      expect(find.text('Sunny, 31°C'), findsOneWidget);
      expect(find.text('Humidity'), findsOneWidget);
      expect(find.text('Wind'), findsOneWidget);
      expect(find.text('Rain'), findsOneWidget);
      expect(find.text('Feels like'), findsOneWidget);
      expect(find.text('35°'), findsOneWidget);
      expect(find.byType(StatBox), findsNWidgets(4));
      expect(find.byType(HourForecast), findsNWidgets(4));
    });
  });

  group('Activity 4 - Cafe Menu', () {
    testWidgets('Shows the banner, the categories and the eight menu items', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const CafeApp());

      expect(find.text('Activity 4 - $studentName'), findsOneWidget);
      expect(find.text('Campus Café'), findsOneWidget);
      expect(find.text('OPEN'), findsOneWidget);
      expect(find.byType(Chip), findsNWidgets(5));

      // The data behind the grid: six from the manual plus my two extra items.
      expect(menu.length, 8);
      expect(menu[6].name, 'Ice Cream');
      expect(menu[7].name, 'Cake Slice');
      expect(menu[7].bestSeller, isTrue);
      expect(menu.where((CafeItem i) => i.bestSeller).length, 3);
    });

    testWidgets('Scrolling the grid reveals my two extra menu items', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1280, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(const CafeApp());

      await tester.dragUntilVisible(
        find.text('Ice Cream'),
        find.byType(GridView),
        const Offset(0, -200),
      );
      await tester.pumpAndSettle();

      expect(find.text('Ice Cream'), findsOneWidget);
      expect(find.text('Cake Slice'), findsOneWidget);
      expect(find.text('Best seller'), findsWidgets);
    });

    testWidgets('The menu grid uses two columns', (WidgetTester tester) async {
      await tester.pumpWidget(const CafeApp());

      final grid = tester.widget<GridView>(find.byType(GridView));
      final delegate =
          grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(delegate.crossAxisCount, 2);
    });
  });

  group('Activity 5 - Settings Page', () {
    testWidgets('Shows the student card, the switch and the six skill chips', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ThemeDemoApp());

      expect(find.text('Activity 5 - $studentName'), findsOneWidget);
      expect(find.text(studentName), findsOneWidget);
      expect(find.text('Theme color: $studentColorName'), findsOneWidget);
      expect(find.text('Dark mode'), findsOneWidget);
      expect(find.text('My skills'), findsOneWidget);
      expect(find.text('HTML'), findsOneWidget);
      expect(find.byType(Chip), findsNWidgets(6));
    });

    testWidgets('Pressing Save shows the SnackBar', (WidgetTester tester) async {
      await tester.pumpWidget(const ThemeDemoApp());

      await tester.tap(find.widgetWithText(FilledButton, 'Save'));
      await tester.pump();

      expect(find.text('Saved!'), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('Flipping the switch switches the app to dark mode', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ThemeDemoApp());

      expect(
        Theme.of(tester.element(find.text('Dark mode'))).brightness,
        Brightness.light,
      );

      await tester.tap(find.byType(SwitchListTile));
      await tester.pumpAndSettle();

      expect(
        Theme.of(tester.element(find.text('Dark mode'))).brightness,
        Brightness.dark,
      );
    });
  });
}
