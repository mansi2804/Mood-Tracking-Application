import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/mood_provider.dart';
import '../models/mood_entry.dart';

class AddMoodScreen extends StatefulWidget {
  const AddMoodScreen({Key? key}) : super(key: key);

  @override
  State<AddMoodScreen> createState() => _AddMoodScreenState();
}

class _AddMoodScreenState extends State<AddMoodScreen> {
  String? _selectedMood;
  final TextEditingController _notesController = TextEditingController();
  bool _isLoading = false; // To track the loading state

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _saveMood() async {
    if (_selectedMood != null) {
      setState(() {
        _isLoading = true;
      });

      final moodEntry = MoodEntry(
        date: DateTime.now(),
        mood: _selectedMood!,
        notes: _notesController.text.trim(),
      );

      try {
        await Provider.of<MoodProvider>(context, listen: false)
            .addMood(moodEntry);

        // Show SnackBar and navigate back
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Mood saved successfully!')),
          );
          Navigator.of(context).pop(); // Pop back to HomeScreen after saving
        }
      } catch (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to save mood: $error')),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a mood.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: AppBar(
                title: const Text(
                  'Add Mood',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Roboto',
                    letterSpacing: 1.2,
                  ),
                ),
                backgroundColor: const Color(0xFF7F7FD5),
                elevation: 0,
              ),
            ),
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF7F7FD5),
                    Color(0xFF86A8E7),
                    Color(0xFF91EAE4)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  DropdownButton<String>(
                    value: _selectedMood,
                    hint: const Text(
                      'Select your mood',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        shadows: [
                          Shadow(
                            color: Color.fromRGBO(0, 0, 0, 0.7),
                            offset: Offset(4.0, 4.0),
                            blurRadius: 8.0,
                          ),
                        ],
                      ),
                    ),
                    items: [
                      'Happy 😄',
                      'Sad 😞',
                      'Calm 😌',
                      'Anxious 😟',
                    ]
                        .map(
                          (mood) => DropdownMenuItem(
                            value: mood,
                            child: Text(
                              mood,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                                letterSpacing: 1.1,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (_selectedMood != value) {
                        setState(() {
                          _selectedMood = value;
                        });
                      }
                    },
                    dropdownColor: Colors.blue.shade300,
                    style: const TextStyle(color: Colors.white),
                    elevation: 8,
                    iconEnabledColor: Colors.white,
                    iconSize: 30,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _notesController,
                    decoration: const InputDecoration(
                      labelText: 'Notes (optional)',
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _saveMood,
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFF7F7FD5)),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
