import 'package:flutter/material.dart';
import 'dart:math';
import '../components/_backButton.dart';
import '../components/_background.dart';
import '../services/datas.dart';

class ColorMatchingGame extends StatefulWidget {
  final int option; // 1 pour couleurs de base, 2 pour couleurs rares

  const ColorMatchingGame({super.key, required this.option});

  @override
  _ColorMatchingGameState createState() => _ColorMatchingGameState();
}

class _ColorMatchingGameState extends State<ColorMatchingGame> {
  late List<ColorData> colors;
  late List<ColorData> currentChoices;
  late ColorData targetColor;
  int score = 0;
  int attempts = 0;
  bool isCorrect = false;
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    colors = widget.option == 1 ? basicColors : rareColors;
    _generateNewRound();
  }

  void _generateNewRound() {
    Random random = Random();
    Set<ColorData> choicesSet = {};
    while (choicesSet.length < 3) {
      choicesSet.add(colors[random.nextInt(colors.length)]);
    }
    currentChoices = choicesSet.toList();
    targetColor = currentChoices[random.nextInt(3)];
    attempts++;
    selectedIndex = null;
    isCorrect = false;
  }

  void _checkMatch(ColorData selectedColor, int index) {
    setState(() {
      if (selectedColor == targetColor) {
        score++;
        isCorrect = true;
      } else {
        isCorrect = false;
      }
      selectedIndex = index;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (attempts < 5) {
        setState(() {
          _generateNewRound();
        });
      } else {
        _showScore();
      }
    });
  }

  void _showScore() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Jeu Terminé'),
        content: Text('Ton score : $score/5'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Retour au menu'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                score = 0;
                attempts = 0;
                _generateNewRound();
                Navigator.pop(context);
              });
            },
            child: const Text('Rejouer'),
          ),
        ],
      ),
    );
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
                  'Amuses-toi à relier les couleurs aux formes',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenHeight * 0.04,
                    color: Colors.orange,
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),

                // Les cercles vides
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(3, (index) {
                    return GestureDetector(
                      onTap: () {
                        _checkMatch(currentChoices[index], index);
                      },
                      child: DragTarget<ColorData>(
                        onWillAcceptWithDetails: (data) => true,
                        onAcceptWithDetails: (receivedColor) {
                          _checkMatch(currentChoices[index], index);
                        },
                        builder: (context, candidateData, rejectedData) {
                          return Container(
                            width: screenHeight * 0.15,
                            height: screenHeight * 0.15,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: currentChoices[index].color,
                                width: 4,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: selectedIndex == index
                                ? Icon(
                              isCorrect ? Icons.check : Icons.close,
                              color: isCorrect ? Colors.green : Colors.red,
                              size: screenHeight * 0.1,
                            )
                                : null,
                          );
                        },
                      ),
                    );
                  }),
                ),

                const Spacer(),

                // La boule colorée
                Draggable<ColorData>(
                  data: targetColor,
                  feedback: Container(
                    width: screenHeight * 0.15,
                    height: screenHeight * 0.15,
                    decoration: BoxDecoration(
                      color: targetColor.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  childWhenDragging: Container(),
                  child: Container(
                    width: screenHeight * 0.15,
                    height: screenHeight * 0.15,
                    decoration: BoxDecoration(
                      color: targetColor.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
