import 'package:flutter/material.dart';

class FlagButton extends StatelessWidget {
  final String mode;
  final String imagePath;
  final VoidCallback onPressed;

  const FlagButton({
    required this.mode,
    required this.imagePath,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String continent;
    switch (mode) {
      case 'Americas':
        continent = 'americas';
        break;
      case 'Europe':
        continent = 'europe';
        break;
      case 'Asia':
        continent = 'asia';
        break;
      case 'Africa':
        continent = 'africa';
        break;
      case 'Master Vexillologist':
        continent = 'restoftheworld';
        break;
      default:
        continent = 'americas';
    }
    return ElevatedButton(
      onPressed: onPressed,
      child: Image.asset(
        'assets/$continent/$imagePath.png',
        width: MediaQuery.of(context).size.width * 0.4,
      ),
    );
  }
}
