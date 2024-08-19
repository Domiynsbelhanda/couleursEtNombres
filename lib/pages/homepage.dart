import 'package:couleursetnombres/components/_background.dart';
import 'package:flutter/material.dart';

import '../components/_buildMenuButton.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenir la taille de l'écran
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Image de fond

          const BackgroundWithOverlay(),


          // Contenu principal
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo en haut
                Image.asset(
                  'assets/images/logo_variant.png',
                  height: screenHeight * 0.15, // Ajuster la taille en fonction de l'écran
                ),
                SizedBox(height: screenHeight * 0.2),
                Text(
                  'Bienvenu(e) dans notre menu\nChoisis une leçon',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenHeight * 0.035,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: screenWidth * 0.04,
                  mainAxisSpacing: screenHeight * 0.02,
                  childAspectRatio: screenWidth * 0.0047, // Maintenir un ratio d'aspect pour les boutons
                  children: [
                    buildMenuButton(context, 'Couleurs \nde base', screenHeight),
                    buildMenuButton(context, 'Couleurs \nrares', screenHeight),
                    buildMenuButton(context, 'Chiffres \nde 1 à 10', screenHeight),
                    buildMenuButton(context, 'Chiffres \nde 1 à 20', screenHeight),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}