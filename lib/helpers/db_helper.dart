
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/mood_entry.dart';

class DBHelper {
  static const String tableName = 'moods';
  static Database? _database;

  static Future<Database> _initializeDB({bool inMemory = false}) async {
    final dbPath = inMemory
        ? ':memory:' // Use in-memory database for tests
        : join(await getDatabasesPath(), 'moods.db');
    return openDatabase(
      dbPath,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            mood TEXT,
            notes TEXT,
            date TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initializeDB();
    return _database!;
  }

  static Future<void> insertMood(MoodEntry mood) async {
    try {
      final db = await database;
      await db.insert(
        tableName,
        mood.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error inserting mood: $e');
    }
  }

  static Future<List<MoodEntry>> fetchMoods() async {
    try {
      final db = await database;
      final data = await db.query(tableName);
      print('Fetched moods: $data');
      return data.map((item) => MoodEntry.fromMap(item)).toList();
    } catch (e) {
      print('Error fetching moods: $e');
      return [];
    }
  }

  static Future<void> deleteMood(int id) async {
    try {
      final db = await database;
      await db.delete(
        tableName,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Error deleting mood: $e');
    }
  }

  static Future<void> closeDB() async {
    final db = await database;
    await db.close();
  }
}