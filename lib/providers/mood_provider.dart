import 'package:flutter/material.dart';
import '../models/mood_entry.dart';
import '../helpers/db_helper.dart';

class MoodProvider with ChangeNotifier {
  List<MoodEntry> _moods = [];
  bool _isLoading = false;

  List<MoodEntry> get moods => _moods;
  bool get isLoading => _isLoading;

  Future<void> fetchMoods() async {
    _isLoading = true;
    notifyListeners();
    try {
      final fetchedMoods = await DBHelper.fetchMoods();
      _moods = fetchedMoods;
      print('Moods fetched: $_moods');
    } catch (error) {
      print('Error fetching moods: $error');
      _moods = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addMood(MoodEntry moodEntry) async {
    try {
      await DBHelper.insertMood(moodEntry);
      _moods.add(moodEntry);
      print('Mood added: $moodEntry');
      notifyListeners();
    } catch (error) {
      print('Error adding mood: $error');
    }
  }

  Future<void> deleteMood(int id) async {
    try {
      await DBHelper.deleteMood(id);
      _moods.removeWhere((mood) => mood.id == id);
      print('Mood deleted: $id');
      notifyListeners();
    } catch (error) {
      print('Error deleting mood: $error');
    }
  }
}