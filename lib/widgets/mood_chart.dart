import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/mood_entry.dart';

class MoodChart extends StatelessWidget {
  final List<MoodEntry> moods;

  const MoodChart({required this.moods, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (moods.isEmpty) {
      return const Center(
        child: Text(
          'No moods to display',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      );
    }

    // Initialize mood counts
    final moodCounts = {
      'Happy 😄': 0,
      'Sad 😞': 0,
      'Calm 😌': 0,
      'Anxious 😟': 0,
      
    };

    for (var mood in moods) {
      if (moodCounts.containsKey(mood.mood)) {
        moodCounts[mood.mood] = (moodCounts[mood.mood] ?? 0) + 1;
      }
    }

    final moodColors = {
      'Happy 😄': Colors.green,
      'Sad 😞': Colors.blue,
      'Calm 😌': Colors.yellow,
      'Anxious 😟': Colors.red,
    };

    
    final chartSections = moodCounts.entries
        .where((entry) => entry.value > 0)
        .map((entry) {
          return PieChartSectionData(
            title: '${entry.value}', 
            value: entry.value.toDouble(),
            color: moodColors[entry.key] ?? Colors.grey, 
            titleStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        })
        .toList();

    return PieChart(
      PieChartData(
        sections: chartSections,
        centerSpaceRadius: 40,
        sectionsSpace: 2,
        borderData: FlBorderData(show: false),
      ),
    );
  }
}
