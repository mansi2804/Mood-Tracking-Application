
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/mood_provider.dart';
import '../widgets/mood_chart.dart';
import 'add_mood_screen.dart';
import 'motivational_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Fetch moods once when the widget is inserted into the widget tree
    Future.microtask(() {
      final moodProvider = Provider.of<MoodProvider>(context, listen: false);
      moodProvider.fetchMoods();
    });
  }

  @override
  Widget build(BuildContext context) {
    final moodProvider = Provider.of<MoodProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MoodTracker',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF7F7FD5),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF7F7FD5), Color(0xFF86A8E7), Color(0xFF91EAE4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Builder(
          builder: (context) {
            if (moodProvider.isLoading) {
              // Debug log for loading state
              print("Loading moods...");
              return const Center(child: CircularProgressIndicator());
            }

            if (moodProvider.moods.isEmpty) {
              // Debug log for empty state
              print("No moods recorded yet!");
              return const Center(
                child: Text(
                  'No moods recorded yet!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              );
            }

            // If we have moods, display the chart and the list
            print("Displaying moods: ${moodProvider.moods}");
            return Column(
              children: [
                Expanded(
                  flex: 2,
                  child: MoodChart(moods: moodProvider.moods),
                ),
                Expanded(
                  flex: 3,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(8.0),
                    itemCount: moodProvider.moods.length,
                    itemBuilder: (ctx, i) {
                      final mood = moodProvider.moods[i];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
                        child: ListTile(
                          title: Text(
                            mood.mood,
                            style: const TextStyle(color: Colors.black),
                          ),
                          subtitle: Text(
                            mood.notes.isNotEmpty ? mood.notes : 'No notes',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          trailing: mood.id != null
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '${mood.date.day}/${mood.date.month}/${mood.date.year}',
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () {
                                        if (mood.id != null) {
                                          showDialog(
                                            context: context,
                                            builder: (ctx) => Dialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  gradient:
                                                      const LinearGradient(
                                                    colors: [
                                                      Color(0xFF7F7FD5),
                                                      Color(0xFF86A8E7),
                                                      Color(0xFF91EAE4)
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const Text(
                                                      'Delete Mood',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                        color: Colors.white,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    const SizedBox(height: 15),
                                                    const Text(
                                                      'Are you sure you want to delete this mood?',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    const SizedBox(height: 20),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Colors.white,
                                                            foregroundColor:
                                                                Colors.black,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.of(ctx)
                                                                .pop(); // Close the dialog
                                                          },
                                                          child: const Text(
                                                              'Cancel'),
                                                        ),
                                                        ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                const Color(
                                                                    0xFFD32F2F), // Red color
                                                            foregroundColor:
                                                                Colors.white,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            moodProvider
                                                                .deleteMood(
                                                                    mood.id!);
                                                            Navigator.of(ctx)
                                                                .pop(); // Close the dialog
                                                          },
                                                          child: const Text(
                                                              'Delete'),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => const AddMoodScreen()),
          );
          // Refresh moods after returning from AddMoodScreen
          moodProvider.fetchMoods();
        },
        backgroundColor: const Color(0xFF7F7FD5),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF7F7FD5),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Motivation',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 1) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => const MotivationalScreen()),
            );
          }
        },
      ),
    );
  }
}