class MoodEntry {
  final int? id;
  final DateTime date;
  final String mood;
  final String notes;

  MoodEntry({
    this.id,
    required this.date,
    required this.mood,
    required this.notes,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'mood': mood,
      'notes': notes,
    };
  }


  factory MoodEntry.fromMap(Map<String, dynamic> map) {
    return MoodEntry(
      id: map['id'] as int?,
      date: DateTime.parse(map['date'] as String),
      mood: map['mood'] as String,
      notes: map['notes'] as String,
    );
  }

  // Override toString for debugging
  @override
  String toString() {
    return 'MoodEntry(id: $id, date: $date, mood: $mood, notes: $notes)';
  }

  // Equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MoodEntry &&
        other.id == id &&
        other.date == date &&
        other.mood == mood &&
        other.notes == notes;
  }

  @override
  int get hashCode => id.hashCode ^ date.hashCode ^ mood.hashCode ^ notes.hashCode;
}
