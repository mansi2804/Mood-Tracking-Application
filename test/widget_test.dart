import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cs442_mp6/widgets/mood_chart.dart'; 
import 'package:cs442_mp6/models/mood_entry.dart'; 


void main() {
  group('MoodChart Widget Tests', () {
    testWidgets('shows message when there are no moods', (tester) async {
      
      final List<MoodEntry> emptyMoods = [];

      // Act: Build the widget with the empty list
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: MoodChart(moods: emptyMoods),
        ),
      ));

      // Assert: Verify the "No moods to display" message is shown
      expect(find.text('No moods to display'), findsOneWidget);
    });

    testWidgets('renders chart with moods correctly', (tester) async {
    
      final List<MoodEntry> moodEntries = [
        MoodEntry(
          date: DateTime.now(),
          mood: 'Happy 😄',
          notes: 'Feeling great!',
        ),
        MoodEntry(
          date: DateTime.now(),
          mood: 'Sad 😞',
          notes: 'Not a good day.',
        ),
        MoodEntry(
          date: DateTime.now(),
          mood: 'Happy 😄',
          notes: 'Had a great lunch.',
        ),
        MoodEntry(
          date: DateTime.now(),
          mood: 'Calm 😌',
          notes: 'Relaxed afternoon.',
        ),
        MoodEntry(
          date: DateTime.now(),
          mood: 'Anxious 😟',
          notes: 'Stress from work.',
        ),
        MoodEntry(
          date: DateTime.now(),
          mood: 'Happy 😄',
          notes: 'Had some coffee!',
        ),
      ];


      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: MoodChart(moods: moodEntries),
        ),
      ));

      expect(find.byType(PieChart), findsOneWidget);
    });
    
    testWidgets('renders pie chart with one or two mood entries', (tester) async {
  // Test for one mood entry
  final List<MoodEntry> oneMoodEntry = [
    MoodEntry(
      date: DateTime.now(),
      mood: 'Happy 😄',
      notes: 'Feeling great!',
    ),
  ];

  // Act: Build the widget with one mood entry
  await tester.pumpWidget(MaterialApp(
    home: Scaffold(
      body: MoodChart(moods: oneMoodEntry),
    ),
  ));

  // Assert: Verify the pie chart is rendered with one section
  expect(find.byType(PieChart), findsOneWidget);
  final pieChartFinder = find.byType(PieChart);
  final pieChartWidget = tester.widget<PieChart>(pieChartFinder);
  expect(pieChartWidget.data.sections.length, 1); // Should have one section for 'Happy 😄'

  // Test for two mood entries
  final List<MoodEntry> twoMoodEntries = [
    MoodEntry(
      date: DateTime.now(),
      mood: 'Happy 😄',
      notes: 'Feeling great!',
    ),
    MoodEntry(
      date: DateTime.now(),
      mood: 'Sad 😞',
      notes: 'Not a good day.',
    ),
  ];

  // Act: Build the widget with two mood entries
  await tester.pumpWidget(MaterialApp(
    home: Scaffold(
      body: MoodChart(moods: twoMoodEntries),
    ),
  ));

  // Assert: Verify the pie chart is rendered with two sections
  expect(find.byType(PieChart), findsOneWidget);
  final pieChartFinderTwo = find.byType(PieChart);
  final pieChartWidgetTwo = tester.widget<PieChart>(pieChartFinderTwo);
  expect(pieChartWidgetTwo.data.sections.length, 2); // Should have two sections for 'Happy 😄' and 'Sad 😞'
});


testWidgets('renders moods with different colors', (tester) async {

  final List<MoodEntry> moodEntries = [
    MoodEntry(
      date: DateTime.now(),
      mood: 'Happy 😄',
      notes: 'Feeling great!',
    ),
    MoodEntry(
      date: DateTime.now(),
      mood: 'Sad 😞',
      notes: 'Not a good day.',
    ),
    MoodEntry(
      date: DateTime.now(),
      mood: 'Calm 😌',
      notes: 'Relaxed afternoon.',
    ),
  ];


  await tester.pumpWidget(MaterialApp(
    home: Scaffold(
      body: MoodChart(moods: moodEntries),
    ),
  ));

  expect(find.byType(PieChart), findsOneWidget);
  

  final pieChartFinder = find.byType(PieChart);
  final pieChartWidget = tester.widget<PieChart>(pieChartFinder);
  

  expect(pieChartWidget.data.sections.length, 3); 
});

    testWidgets('renders no undefined mood sections', (tester) async {
   
      final List<MoodEntry> moodEntries = [
        MoodEntry(
          date: DateTime.now(),
          mood: 'Excited 😀', // Undefined mood
          notes: 'Feeling awesome!',
        ),
      ];


      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: MoodChart(moods: moodEntries),
        ),
      ));

 
      expect(find.byType(PieChart), findsOneWidget); 
      expect(find.text('Excited 😀: 1'),
          findsNothing); 
    });
  });
}
