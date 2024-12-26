import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/mood_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MoodTrackerApp());

}

class MoodTrackerApp extends StatelessWidget {
  const MoodTrackerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MoodProvider(),
      child: MaterialApp(
        title: 'MoodTracker',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomeScreen(),
      ),
    );
  }
}
