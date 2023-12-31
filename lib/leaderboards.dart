import 'dart:convert';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'login.dart';

class LeaderboardsPage extends StatefulWidget {
  const LeaderboardsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LeaderboardsPageState createState() => _LeaderboardsPageState();
}

class _LeaderboardsPageState extends State<LeaderboardsPage> {
  List<LeaderboardEntry> leaderboardEntries = [];

  @override
  void initState() {
    super.initState();
    _fetchLeaderboardEntries();
  }

  Future<void> _fetchLeaderboardEntries() async {
    const url = 'https://guesstheflaggame.000webhostapp.com/leaderboard.php'; // Replace with your actual server URL

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Parse the response and update the leaderboardEntries list
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          leaderboardEntries = data.map((entry) => LeaderboardEntry.fromJson(entry)).toList();
        });
      } else {
        print('Failed to fetch leaderboard entries. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboards'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LogInPage()),
              );
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Leaderboards',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16.0),
              _buildLeaderboardTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeaderboardTable() {
    return Table(
      border: TableBorder.all(),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: Colors.grey[300],
          ),
          children: [
            _buildTableHeader('Nickname', Colors.white, Colors.lightGreen),
            _buildTableHeader('Final Score', Colors.white, Colors.pinkAccent),
          ],
        ),
        for (final entry in leaderboardEntries)
          TableRow(
            children: [
              TableCell(
                child: Container(
                  color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      entry.nickname,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              TableCell(
                child: Container(
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      entry.finalScore.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildTableHeader(String text, Color textColor, Color backgroundColor) {
    return Container(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

class LeaderboardEntry {
  final String nickname;
  final int finalScore;

  LeaderboardEntry({required this.nickname, required this.finalScore});

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      nickname: json['nickname'] ?? '',
      finalScore: json['finalScore'] ?? 0,
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LeaderboardsPage(),
    );
  }
}




