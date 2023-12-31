import 'package:flutter/material.dart';
import 'leaderboards.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class NicknamePage extends StatefulWidget {
  final int finalScore;

  const NicknamePage({Key? key, required this.finalScore}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NicknamePageState createState() => _NicknamePageState();
}

class _NicknamePageState extends State<NicknamePage> {
  final TextEditingController _nicknameController = TextEditingController();

  Future<void> _sendDataToServer(String nickname, int finalScore) async {
    const url = 'https://guesstheflaggame.000webhostapp.com/nickname.php'; // Replace with your actual server URL

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'nickname': nickname,
          'finalScore': finalScore.toString(),
        },
      );

      if (response.statusCode == 200) {
        print('Server response: ${response.body}');
      } else {
        print('Failed to send data to the server. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nickname'),
      ),
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Give yourself a nickname',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _nicknameController,
                style: const TextStyle(color: Colors.red),
                decoration: const InputDecoration(
                  labelText: 'Nickname',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  fillColor: Colors.black,
                  filled: true,
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  final String nickname = _nicknameController.text;
                  print('Nickname: $nickname');
                  await _sendDataToServer(nickname, widget.finalScore);

                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LeaderboardsPage(
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text(
                  'Proceed',
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


