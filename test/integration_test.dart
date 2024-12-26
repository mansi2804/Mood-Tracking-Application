import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:cs442_mp6/models/mood_entry.dart';
import 'package:cs442_mp6/screens/home_screen.dart';
import 'package:cs442_mp6/providers/mood_provider.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  group('Integration Test: Mood Entry and Chart Update', () {
    testWidgets('should add mood entry and update the chart', (WidgetTester tester) async {
      // Mock data
      final List<MoodEntry> mockMoods = [
        MoodEntry(date: DateTime.now(), mood: 'Happy 😄', notes: 'Feeling great!'),
        MoodEntry(date: DateTime.now(), mood: 'Sad 😞', notes: 'Not a good day.'),
      ];

      // Mock provider
      final mockProvider = MockMoodProvider(mockMoods);

      // Build the widget tree with the mock provider
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<MoodProvider>.value(value: mockProvider),
          ],
          child: const MaterialApp(home: HomeScreen()),
        ),
      );

      // Verify initial state
      await tester.pumpAndSettle();
      expect(find.byType(PieChart), findsOneWidget);
      expect(find.text('Happy 😄'), findsOneWidget);
      expect(find.text('Sad 😞'), findsOneWidget);

      // Simulate adding a new mood entry
      mockProvider.addMood(MoodEntry(
        date: DateTime.now(),
        mood: 'Calm 😌',
        notes: 'Relaxed afternoon.',
      ));
      await tester.pumpAndSettle();

      // Verify the updated state
      expect(find.text('Calm 😌'), findsOneWidget);
      expect(find.text('Relaxed afternoon.'), findsOneWidget);
    });
  });
}

// Mock provider class
class MockMoodProvider extends ChangeNotifier implements MoodProvider {
  List<MoodEntry> _moods;

  MockMoodProvider(this._moods);

  @override
  List<MoodEntry> get moods => _moods;

  @override
  bool get isLoading => false;

  @override
  Future<void> fetchMoods() async {
    // No-op for mock
  }

  @override
  Future<void> addMood(MoodEntry moodEntry) async {
    _moods.add(moodEntry);
    notifyListeners();
  }

  @override
  Future<void> deleteMood(int id) async {
    _moods.removeWhere((mood) => mood.id == id);
    notifyListeners();
  }
}