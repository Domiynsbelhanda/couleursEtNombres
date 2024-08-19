import 'package:flutter/material.dart';

class BackgroundWithOverlay extends StatelessWidget {
  final double opacity;
  final String imagePath;

  const BackgroundWithOverlay({
    super.key,
    this.opacity = 0.6,
    this.imagePath = 'assets/images/background.jpg',
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            color: Colors.white.withOpacity(opacity), // Utilise l'opacité passée en paramètre
          ),
        ),
      ],
    );
  }
}
