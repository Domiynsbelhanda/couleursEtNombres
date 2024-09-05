import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../components/_backButton.dart';
import '../components/_background.dart';
import '../services/datas.dart';

class ColorBase extends StatefulWidget {
  final int option; // 1 pour couleurs de base, 2 pour couleurs rares

  const ColorBase({super.key, required this.option});

  @override
  _ColorBaseState createState() => _ColorBaseState();
}

class _ColorBaseState extends State<ColorBase> {
  int currentIndex = 0;
  late List<ColorData> colors;
  late FlutterTts flutterTts;

  @override
  void initState() {
    super.initState();
    colors = widget.option == 1 ? basicColors : rareColors;
    flutterTts = FlutterTts();
    _initTts();
  }

  Future<void> _initTts() async {
    await flutterTts.setLanguage("fr-FR"); // Définit la langue en français
    await flutterTts.setSpeechRate(0.5);   // Ajuste la vitesse de parole (0.5 est une valeur assez naturelle)
    await flutterTts.setPitch(1.5);        // Ajuste la hauteur de la voix (1.5 est plus aiguë, semblable à une enfant)
  }

  Future<void> _speak(String text) async {
    await flutterTts.speak(text);
  }

  void _nextPage() {
    setState(() {
      if (currentIndex < (colors.length / 2).ceil() - 1) {
        currentIndex++;
      }
    });
  }

  void _previousPage() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundWithOverlay(),

          Padding(
            padding: EdgeInsets.only(left: screenHeight * 0.04, top: screenHeight * 0.08),
            child: backButton(context),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: screenHeight * 0.15),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  'Couleurs',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenHeight * 0.07,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                Text(
                  widget.option == 1
                      ? 'Apprends les couleurs de base avec nous'
                      : 'Apprends les couleurs rares avec nous',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenHeight * 0.04,
                    color: Colors.orange,
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: screenHeight / 1.7),
            child: SizedBox(
              height: screenHeight * 0.5,
              child: Column(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onHorizontalDragEnd: (details) {
                        if (details.primaryVelocity! < 0) {
                          _nextPage(); // Swiped Left
                        } else if (details.primaryVelocity! > 0) {
                          _previousPage(); // Swiped Right
                        }
                      },
                      child: GridView.builder(
                        itemCount: 2,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          mainAxisSpacing: screenHeight * 0.05,
                          crossAxisSpacing: 0,
                        ),
                        itemBuilder: (context, index) {
                          int colorIndex = index + currentIndex * 2;
                          if (colorIndex >= colors.length) return Container();
                          return GestureDetector(
                            onTap: () {
                              _speak(colors[colorIndex].name); // Prononce la couleur
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: screenHeight * 0.15,
                                  height: screenHeight * 0.15,
                                  decoration: BoxDecoration(
                                    color: colors[colorIndex].color,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  colors[colorIndex].name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_left,
                            size: screenHeight * 0.15, color: Colors.orange),
                        onPressed: _previousPage,
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_right,
                            size: screenHeight * 0.15, color: Colors.orange),
                        onPressed: _nextPage,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
