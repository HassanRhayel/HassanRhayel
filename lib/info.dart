import 'package:flutter/material.dart';

import 'flag_guess_page.dart';

class InfoPage extends StatefulWidget {
  final String title;
  final String text;
  final String mode;

  const InfoPage({Key? key, required this.title, required this.text, required this.mode}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.black,
            height: MediaQuery.of(context).size.height * 0.9,
            child: Center(
              child: Text(
                widget.text,
                style: const TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.1,
            child: Center(
              child: AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(seconds: 1),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FlagGuessPage(mode: widget.mode,)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                    backgroundColor: Colors.black,
                  ),
                  child: const Text('Begin'),
                ),
              ),
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
      home: InfoPage(
        title: 'Americas',
        text: 'The Americas, continents of North America and South America, as well as the region of Central America and the Caribbean.\n\nIt covers 8% of Earth\'s total surface area and 28.4% of its land area.\n\nIt has 35 Countries!',
        mode: 'Americas',
      ),
    ),
  );

  runApp(
    const MaterialApp(
      home: InfoPage(
        title: 'Europe',
        text: 'Europe, continents of Northern Europe, Western Europe, Eastern Europe, and Southern Europe.\n\nIt covers about 10.18 million square Km, or 2% of Earth\'s surface (6.8% of land area).\n\nIt has 46 Countries!',
        mode:'Europe',
      ),
    ),
  );

  runApp(
    const MaterialApp(
      home: InfoPage(
        title: 'Asia',
        text: 'Asia is the largest continent in the world by both land area and population.\n\nIt covers an area of more than 44 million square Km, about 30% of Earth\'s total land area and 8% of Earth\'s total surface area.\n\nIt has 47 Countries!',
        mode: 'Asia',
      ),
    ),
  );

  runApp(
    const MaterialApp(
      home: InfoPage(
        title: 'Africa',
        text: 'Africa is the world\'s second-largest and second-most populous continent, after Asia in both aspects. At about 30.3 million square Km including adjacent islands.\n\nIt covers 20% of Earth\'s land area and 6% of its total surface area.\n\nIt has 51 Countries!',
        mode:'Africa',
      ),
    ),
  );

  runApp(
    const MaterialApp(
      home: InfoPage(
        title: 'Master Vexillologist',
        text: 'If someone is particularly skilled at identifying flags, it could be considered a talent or a form of expertise in vexillology, which is the study of flags. While there may not be a specific official "achievement" for guessing flags, individuals with a strong knowledge of flags might find recognition or enjoyment.\n\nAre you capable of finishing this mode...?\n\nHave a goodluck!',
         mode:'Master Vexillologist',
      ),
    ),
  );
}
