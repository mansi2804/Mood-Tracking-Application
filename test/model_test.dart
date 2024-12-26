
import 'package:flutter_test/flutter_test.dart';

// Assuming MoodEntry class is defined as follows:
class MoodEntry {
  final String? id;
  final DateTime date;
  final String mood;
  final String notes;

  MoodEntry({this.id, required this.date, required this.mood, required this.notes});

  // toMap method
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'mood': mood,
      'notes': notes,
    };
  }

  // fromMap method
  factory MoodEntry.fromMap(Map<String, dynamic> map) {
    return MoodEntry(
      id: map['id'],
      date: DateTime.parse(map['date']),
      mood: map['mood'],
      notes: map['notes'],
    );
  }

  // Equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MoodEntry &&
        other.date == date &&
        other.mood == mood &&
        other.notes == notes;
  }

  @override
  int get hashCode => date.hashCode ^ mood.hashCode ^ notes.hashCode;

  // toString method
  @override
  String toString() {
    return 'MoodEntry(id: $id, date: $date, mood: $mood, notes: $notes)';
  }
}

// Assuming User class is defined as follows:
class User {
  final String name;
  final int age;

  User({required this.name, required this.age});

  String getDetails() {
    return 'Name: $name, Age: $age';
  }
}

void main() {
  group('Model Tests', () {
    
    test('toMap should correctly convert MoodEntry to Map', () {
      final moodEntry = MoodEntry(
        date: DateTime(2024, 12, 6),
        mood: 'Happy 😄',
        notes: 'Had a great day!',
      );

      final map = moodEntry.toMap();
      expect(map['date'], '2024-12-06T00:00:00.000');
      expect(map['mood'], 'Happy 😄');
      expect(map['notes'], 'Had a great day!');
      expect(map['id'], isNull); 
    });

    test('fromMap should correctly convert Map to MoodEntry', () {
      final map = {
        'id': null,
        'date': '2024-12-06T00:00:00.000',
        'mood': 'Happy 😄',
        'notes': 'Had a great day!',
      };

      final moodEntry = MoodEntry.fromMap(map);
      expect(moodEntry.date, DateTime(2024, 12, 6));
      expect(moodEntry.mood, 'Happy 😄');
      expect(moodEntry.notes, 'Had a great day!');
      expect(moodEntry.id, isNull);
    });

    test('Equality operator should return true for equal MoodEntries', () {
      final moodEntry1 = MoodEntry(
        date: DateTime(2024, 12, 6),
        mood: 'Happy 😄',
        notes: 'Had a great day!',
      );

      final moodEntry2 = MoodEntry(
        date: DateTime(2024, 12, 6),
        mood: 'Happy 😄',
        notes: 'Had a great day!',
      );

      expect(moodEntry1 == moodEntry2, isTrue);
    });


    test('toString should return the correct string representation of MoodEntry', () {
      final moodEntry = MoodEntry(
        date: DateTime(2024, 12, 6),
        mood: 'Happy 😄',
        notes: 'Had a great day!',
      );

      expect(moodEntry.toString(), 'MoodEntry(id: null, date: 2024-12-06 00:00:00.000, mood: Happy 😄, notes: Had a great day!)');
    });

 
    test('User model should correctly store and retrieve data', () {
      final user = User(name: 'Mansi Patil', age: 24);

      expect(user.name, 'Mansi Patil');
      expect(user.age, 24);
      expect(user.getDetails(), 'Name: Mansi Patil, Age: 24');
    });


    test('MoodEntry should handle null and default values correctly', () {
      // MoodEntry with only date
      final moodEntry1 = MoodEntry(
        date: DateTime(2024, 12, 6),
        mood: 'Neutral 😐',
        notes: '',
      );
      expect(moodEntry1.date, DateTime(2024, 12, 6));
      expect(moodEntry1.mood, 'Neutral 😐');
      expect(moodEntry1.notes, '');
      
      // MoodEntry with all required fields
      final moodEntry2 = MoodEntry(
        date: DateTime.now(),
        mood: 'Excited 😃',
        notes: 'Excited about the new project!',
      );
      expect(moodEntry2.date, isNotNull);
      expect(moodEntry2.mood, 'Excited 😃');
      expect(moodEntry2.notes, 'Excited about the new project!');
    });
  });
}
