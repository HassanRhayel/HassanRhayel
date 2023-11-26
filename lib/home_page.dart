import 'package:flutter/material.dart';
import 'game_modes.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guess The Flag!'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.red,
              Colors.red,
              Colors.white,
              Colors.white,
              Colors.red,
              Colors.red,
            ],
            stops: [0.0, 0.3, 0.3, 0.7, 0.7, 1.0],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Guess',
                style: TextStyle(
                  fontSize: 32.0,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'The',
                style: TextStyle(
                  fontSize: 32.0,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Flag!',
                style: TextStyle(
                  fontSize: 32.0,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ModeSelectionPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  textStyle: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                ),
                child: const Text('Play'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


