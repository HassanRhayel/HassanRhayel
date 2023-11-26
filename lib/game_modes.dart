import 'package:flutter/material.dart';
import 'package:guesstheflag/info.dart';
import 'info.dart' show InfoPage;

class ModeSelectionPage extends StatelessWidget {
  const ModeSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.black,
            height: MediaQuery.of(context).size.height * 0.2,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               Text(
              'Game Modes',
              style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
              ),
              ],
            ),

          ),
          Container(
            color: Colors.black,
            height: MediaQuery.of(context).size.height * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const InfoPage(
                          title: 'Americas',
                          text: 'The Americas, continents of North America and South America, as well as the region of Central America and the Caribbean.\n\nIt covers 8% of Earth\'s total surface area and 28.4% of its land area.\n\nIt has 35 Countries!',
                          mode: 'Americas',)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, backgroundColor: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  ),
                  child: const Text('Americas'),
                ),
              ],
            ),

          ),
          Container(
            color: Colors.black,
            height: MediaQuery.of(context).size.height * 0.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InfoPage(
                          title: 'Europe',
                          text: 'Europe, continents of Northern Europe, Western Europe, Eastern Europe, and Southern Europe.\n\nIt covers about 10.18 million km squared, or 2% of Earth\'s surface (6.8% of land area).\n\nIt has 46 Countries!',
                          mode: 'Europe',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, backgroundColor: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                  ),
                  child: const Text('Europe'),
                ),
              ],
            ),

          ),
          // Bottom 50% - White with Buttons
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InfoPage(
                          title: 'Asia',
                          text: 'Asia is the largest continent in the world by both land area and population.\n\nIt covers an area of more than 44 million square Km, about 30% of Earth\'s total land area and 8% of Earth\'s total surface area.\n\nIt has 47 Countries!',
                          mode: 'Asia',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    textStyle: const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                  ),
                  child: const Text('Asia'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InfoPage(
                          title: 'Africa',
                          text: 'Africa is the world\'s second-largest and second-most populous continent, after Asia in both aspects. At about 30.3 million square Km including adjacent islands.\n\nIt covers 20% of Earth\'s land area and 6% of its total surface area.\n\nIt has 51 Countries!',
                          mode: 'Africa',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    textStyle: const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                  ),
                  child: const Text('Africa'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InfoPage(
                          title: 'Master Vexillologist',
                          text: 'If someone is particularly skilled at identifying flags, it could be considered a talent or a form of expertise in vexillology, which is the study of flags. While there may not be a specific official "achievement" for guessing flags, individuals with a strong knowledge of flags might find recognition or enjoyment.\n\nAre you capable of finishing this mode...?\n\nHave a goodluck!',
                          mode: 'Master Vexillologist',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    textStyle: const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                  ),
                  child: const Text('Master Vexillologist'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: ModeSelectionPage(),
    ),
  );
}

