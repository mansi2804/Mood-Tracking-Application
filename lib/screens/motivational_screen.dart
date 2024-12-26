import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MotivationalScreen extends StatelessWidget {
  const MotivationalScreen({Key? key}) : super(key: key);

  Future<String> fetchQuote() async {
    final response =
        await http.get(Uri.parse('https://zenquotes.io/api/random'));
    final data = jsonDecode(response.body);
    return data[0]['q'] + ' - ' + data[0]['a'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Motivational Quotes',  style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Roboto', // You can change the font family here if needed
              // Adds some space between letters for style
            ),
          ),
        backgroundColor:Color(0xFF7F7FD5), // Make AppBar transparent
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              // Reload the quote when refresh icon is clicked
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (ctx) => const MotivationalScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF7F7FD5), Color(0xFF86A8E7), Color(0xFF91EAE4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FutureBuilder(
          future: fetchQuote(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Failed to fetch quote.'));
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      snapshot.data as String,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black.withOpacity(0.6),
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        // Refresh the quote
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => const MotivationalScreen()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFF7F7FD5)),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Get New Quote',
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
          },
        ),
      ),
    );
  }
}
