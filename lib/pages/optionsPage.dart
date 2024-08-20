import 'package:couleursetnombres/components/_backButton.dart';
import 'package:couleursetnombres/pages/colorbase.dart';
import 'package:couleursetnombres/pages/colorrare.dart';
import 'package:flutter/material.dart';

import '../components/_background.dart';

class OptionPage extends StatelessWidget {
  final int option;

  const OptionPage({super.key, required this.option});

  getOptionText() {
    switch (option) {
      case 1:
        return const ColorBase();
      case 2:
        return const ColorRare();
    // Ajoutez d'autres cas ici pour chaque option
      default:
        return 'Option inconnue';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundWithOverlay(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: screenHeight * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                backButton(context),

                const SizedBox(height: 20),
                Center(
                  child: Column(
                    children: [

                      Image.asset(
                        'assets/images/logo_variant.png',
                        height: screenHeight * 0.15, // Ajuster la taille en fonction de l'écran
                      ),

                      SizedBox(height: screenHeight * 0.15),
                      Text(
                        'Choisis une option',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: screenHeight * 0.04,
                          color: Colors.orange,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => getOptionText()),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'Apprendre',
                                style: TextStyle(color: Colors.white, fontSize: 24),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              // Action pour "Jouer"
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'Jouer',
                                style: TextStyle(color: Colors.white, fontSize: 24),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
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