import 'package:flutter/material.dart';

import '../pages/optionsPage.dart';

Widget buildMenuButton(BuildContext context, String text, double screenHeight, option) {

  void navigateToOption(BuildContext context, int option) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OptionPage(option: option),
      ),
    );
  }

  return ElevatedButton(
    onPressed: () => navigateToOption(context, option),
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
        fontSize: screenHeight * 0.025,
        color: Colors.white,
      ),
      softWrap: true, // Permet le retour à la ligne
    ),
  );
}
