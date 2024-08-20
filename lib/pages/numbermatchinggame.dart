import 'package:flutter/material.dart';
import 'dart:math';

import '../components/_backButton.dart';
import '../components/_background.dart';

class NumberMatchingGame extends StatefulWidget {
  final int option; // 1 pour chiffres de 1 à 10, 2 pour chiffres de 1 à 100

  const NumberMatchingGame({super.key, required this.option});

  @override
  _NumberMatchingGameState createState() => _NumberMatchingGameState();
}

class _NumberMatchingGameState extends State<NumberMatchingGame> {
  late List<int> numbers;
  late List<int> currentChoices;
  late int targetNumber;
  int score = 0;
  int attempts = 0;
  bool isCorrect = false;
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    numbers = widget.option == 3 ? List.generate(10, (index) => index + 1) : List.generate(100, (index) => index + 1);
    _generateNewRound();
  }

  void _generateNewRound() {
    Random random = Random();
    Set<int> choicesSet = {};
    while (choicesSet.length < 3) {
      choicesSet.add(numbers[random.nextInt(numbers.length)]);
    }
    currentChoices = choicesSet.toList();
    targetNumber = currentChoices[random.nextInt(3)];
    attempts++;
    selectedIndex = null;
    isCorrect = false;
  }

  void _checkMatch(int selectedNumber, int index) {
    setState(() {
      if (selectedNumber == targetNumber) {
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
                  'Nombres',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenHeight * 0.07,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                Text(
                  'Trouve les chiffres correspondants',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenHeight * 0.04,
                    color: Colors.orange,
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),

                // Les cercles contenant les chiffres
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(3, (index) {
                    return GestureDetector(
                      onTap: () {
                        _checkMatch(currentChoices[index], index);
                      },
                      child: DragTarget<int>(
                        onWillAccept: (data) => true,
                        onAccept: (receivedNumber) {
                          _checkMatch(currentChoices[index], index);
                        },
                        builder: (context, candidateData, rejectedData) {
                          return Container(
                            width: screenHeight * 0.14,
                            height: screenHeight * 0.14,
                            decoration: BoxDecoration(
                              color: _getRandomColor(), // Couleur aléatoire
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Text(
                                    currentChoices[index].toString(),
                                    style: TextStyle(
                                      fontSize: screenHeight * 0.05,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (selectedIndex == index)
                                    Icon(
                                      isCorrect ? Icons.check : Icons.close,
                                      color: isCorrect ? Colors.green : Colors.red,
                                      size: screenHeight * 0.1,
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                ),

                const Spacer(),

                // Le cercle contenant le nombre à trouver
                Draggable<int>(
                  data: targetNumber,
                  feedback: Container(
                    width: screenHeight * 0.13,
                    height: screenHeight * 0.13,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        targetNumber.toString(),
                        style: TextStyle(
                          fontSize: screenHeight * 0.05,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  childWhenDragging: Container(),
                  child: Container(
                    width: screenHeight * 0.15,
                    height: screenHeight * 0.15,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        targetNumber.toString(),
                        style: TextStyle(
                          fontSize: screenHeight * 0.05,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Méthode pour obtenir une couleur aléatoire.
  Color _getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
}
