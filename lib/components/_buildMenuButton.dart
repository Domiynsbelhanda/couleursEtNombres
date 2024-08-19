import 'package:flutter/material.dart';

Widget buildMenuButton(BuildContext context, String text, double screenHeight) {
  return ElevatedButton(
    onPressed: () {
      // Action à définir pour chaque bouton
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF5cc2ce), // Couleur turquoise des boutons
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(screenHeight * 0.02),
    ),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: screenHeight * 0.03,
        color: Colors.white,
      ),
      softWrap: true, // Permet le retour à la ligne
    ),
  );
}
