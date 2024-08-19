import 'package:flutter/material.dart';

Widget backButton(BuildContext context){
  return GestureDetector(
    onTap: () {
      Navigator.pop(context); // Retour à la page précédente
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        'retour',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    ),
  );
}