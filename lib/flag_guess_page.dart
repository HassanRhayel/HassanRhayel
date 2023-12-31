import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'flag_button.dart';
import 'play.dart';
import 'nickname.dart';

class FlagGuessPage extends StatefulWidget {
  final String mode;
  const FlagGuessPage({Key? key, required this.mode, }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FlagGuessPageState createState() => _FlagGuessPageState();
}

class _FlagGuessPageState extends State<FlagGuessPage> {
  late List<String> _countries;

  List<String> _remainingCountries = [];
  String _correctCountry = '';
  List<String> _choices = [];
  String _resultMessage = '';
  Timer? _timer;
  int _secondsRemaining = 10;
  int _score = 0;
  bool _gameOver = false;

  double _opacity = 1.0;
  double _timeOpacity = 1.0;

  @override
  void initState() {
    super.initState();
    _initializeCountries();
    _remainingCountries = List.from(_countries);
    _startNewRound();
  }
  void _initializeCountries() {
    switch (widget.mode) {
      case 'Americas':
        _countries = ['antigua-and-barbuda', 'argentina', 'bahamas', 'barbados', 'belize', 'bolivia', 'brazil', 'canada', 'chile', 'colombia', 'costa-rica', 'cuba', 'dominica', 'dominican-republic' ,'ecuador',
          'el-salvador', 'grenada', 'guatemala', 'guyana' ,'haiti', 'honduras', 'jamaica', 'mexico', 'nicaragua' ,'panama', 'paraguay', 'peru', 'saint-kitts-and-nevis', 'saint-lucia' ,'saint-vincent-and-the-grenadines',
          'suriname', 'trinidad-and-tobago', 'uruguay', 'united-states' ,'venezuela'];
        break;
      case 'Europe':
        _countries = ['albania', 'andorra', 'austria', 'belarus', 'belgium', 'bosnia-and-herzegovina',
          'bulgaria', 'croatia', 'czech-republic', 'denmark', 'estonia', 'finland', 'france', 'georgia',
          'germany', 'greece', 'hungary', 'iceland', 'ireland', 'italy', 'kosovo', 'latvia',
          'liechtenstein', 'lithuania', 'luxembourg', 'malta', 'moldova', 'monaco', 'montenegro', 'netherlands',
          'north-macedonia', 'norway', 'poland', 'portugal', 'romania', 'san-marino', 'serbia', 'slovakia',
          'slovenia', 'spain', 'sweden', 'switzerland', 'turkey', 'ukraine', 'united-kingdom'];
        break;
      case 'Asia':
        _countries = [
          'afghanistan', 'armenia', 'azerbaijan', 'bahrain', 'bangladesh', 'bhutan', 'brunei', 'cambodia', 'china', 'cyprus',
          'india', 'indonesia', 'iran', 'iraq', 'japan', 'jordan', 'kazakhstan', 'kuwait', 'kyrgyzstan', 'laos',
          'lebanon', 'malaysia', 'maldives', 'mongolia', 'myanmar', 'nepal', 'north-korea', 'oman', 'pakistan',
          'palestine', 'philippines', 'qatar', 'russia', 'saudi-arabia', 'singapore', 'south-korea', 'sri-lanka',
          'syria', 'taiwan', 'tajikistan', 'thailand', 'timor-leste', 'turkmenistan', 'united-arab-emirates', 'uzbekistan',
          'vietnam', 'yemen'];
        break;
      case 'Africa':
        _countries = [
    'algeria', 'angola', 'benin', 'botswana', 'burkina-faso', 'burundi', 'cameroon', 'central-african-republic',
    'chad', 'comoros', 'democratic-republic-of-the-congo', 'djibouti', 'egypt', 'equatorial-guinea', 'eritrea',
    'ethiopia', 'gabon', 'gambia', 'ghana', 'guinea', 'guinea-bissau', 'ivory-coast', 'kenya',
    'lesotho', 'liberia', 'libya', 'madagascar', 'malawi', 'mali', 'mauritania', 'mauritius', 'morocco', 'mozambique',
    'namibia', 'niger', 'nigeria', 'rwanda', 'sao-tome-and-principe', 'senegal', 'seychelles', 'sierra-leone',
    'somalia', 'south-africa', 'south-sudan', 'sudan', 'tanzania', 'togo', 'tunisia', 'uganda', 'zambia', 'zimbabwe'
    ];
        break;
      case 'Master Vexillologist':
        _countries = [
          'australia', 'fiji', 'kiribati', 'marshall-islands', 'micronesia', 'nauru', 'new-zealand',
          'palau', 'papua-new-guinea', 'samoa', 'solomon-islands', 'tonga', 'tuvalu', 'vanuatu'];
        break;
      default:
        _countries = [];
    }
  }

  void _startNewRound() {
    final random = Random();

    if (_remainingCountries.isEmpty) {
      setState(() {
        _resultMessage = 'Game over!  Your final score: $_score';
        _gameOver = true;
      });

      _startFading();
      _startTimeFading();

      return;
    }
    _correctCountry = _remainingCountries[random.nextInt(_remainingCountries.length)];
    _choices = _generateChoices(_correctCountry);
    _resultMessage = '';

    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsRemaining = 10;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer?.cancel();
          _startNewRound();
        }
      });
    });
  }

  List<String> _generateChoices(String correctCountry) {
    final random = Random();
    List<String> choices = [_correctCountry];
    while (choices.length < 4) {
      String randomCountry = _countries[random.nextInt(_countries.length)];
      if (!choices.contains(randomCountry)) {
        choices.add(randomCountry);
      }
    }
    choices.shuffle();
    return choices;
  }
  void _makeGuess(String selectedCountry) {
    setState(() {
      _timer?.cancel();
      if (selectedCountry == _correctCountry) {
        _score++;
      }
      _remainingCountries.remove(_correctCountry);

      _startNewRound();
    });
  }
  void _backToMainMenu() {
    if (_gameOver) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }
  void _startFading() {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        if (_opacity > 0.0) {
          _opacity -= 1.0;
          _opacity = _opacity.clamp(0.0, 1.0);
        } else {
          timer.cancel();
        }
      });
    });
  }
  void _startTimeFading() {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        if (_timeOpacity > 0.0) {
          _timeOpacity -= 0.5;
          _timeOpacity = _timeOpacity.clamp(0.0, 0.5);
        } else {
          timer.cancel();
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: _opacity,
                  child: Text(
                    _correctCountry,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: _opacity,
                      child: FlagButton(
                        imagePath: _choices[0],
                        onPressed: () => _makeGuess(_choices[0]),
                        mode: widget.mode,
                      ),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: _opacity,
                      child: FlagButton(
                        imagePath: _choices[1],
                        onPressed: () => _makeGuess(_choices[1]),
                        mode: widget.mode,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: _opacity,
                      child: FlagButton(
                        imagePath: _choices[2],
                        onPressed: () => _makeGuess(_choices[2]),
                        mode: widget.mode,
                      ),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: _opacity,
                      child: FlagButton(
                        imagePath: _choices[3],
                        onPressed: () => _makeGuess(_choices[3]),
                        mode: widget.mode,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (!_gameOver)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  Text(
                    'Time remaining: $_secondsRemaining seconds',
                    style: const TextStyle(fontSize: 20.0, color: Colors.red),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Score: $_score',
                    style: const TextStyle(fontSize: 20.0, color: Colors.green),
                  ),
                ],
              ),
            ),
          if (_resultMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Center(
                child: Text(
                  _resultMessage,
                  style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          if (_gameOver)
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NicknamePage(finalScore: _score),
                  ),
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
              child: const Text('Leaderboards'),
            ),
          Visibility(
            visible: _gameOver,
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _backToMainMenu,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    textStyle: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                  ),
                  child: const Text('Back to Main Menu'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}




