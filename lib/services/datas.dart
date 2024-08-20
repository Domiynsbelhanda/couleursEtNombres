// lib/datas.dart

import 'package:flutter/material.dart';

class ColorData {
  final String name;
  final Color color;

  ColorData({required this.name, required this.color});
}

List<ColorData> basicColors = [
  ColorData(name: "Rouge", color: Colors.red),
  ColorData(name: "Orange", color: Colors.orange),
  ColorData(name: "Bleu", color: Colors.blue),
  ColorData(name: "Vert", color: Colors.green),
  ColorData(name: "Jaune", color: Colors.yellow),
  ColorData(name: "Violet", color: Colors.purple),
  ColorData(name: "Cyan", color: Colors.cyan),
  ColorData(name: "Magenta", color: Colors.pink),
  ColorData(name: "Marron", color: Colors.brown),
  ColorData(name: "Noir", color: Colors.black),
  ColorData(name: "Blanc", color: Colors.white),
  ColorData(name: "Gris", color: Colors.grey),
  ColorData(name: "Rose", color: Colors.pinkAccent),
];

List<ColorData> rareColors = [
  ColorData(name: "Chartreuse", color: Color(0xFF7FFF00)),
  ColorData(name: "Vermillon", color: Color(0xFFE34234)),
  ColorData(name: "Indigo", color: Color(0xFF4B0082)),
  ColorData(name: "Turquoise", color: Color(0xFF40E0D0)),
  ColorData(name: "Améthyste", color: Color(0xFF9966CC)),
  ColorData(name: "Cramoisi", color: Color(0xFFDC143C)),
  ColorData(name: "Sépia", color: Color(0xFF704214)),
  ColorData(name: "Ocre", color: Color(0xFFCC7722)),
  ColorData(name: "Pourpre", color: Color(0xFF800080)),
  ColorData(name: "Fuchsia", color: Color(0xFFFF00FF)),
  ColorData(name: "Pistache", color: Color(0xFF93C572)),
  ColorData(name: "Aubergine", color: Color(0xFF3B0910)),
  ColorData(name: "Prune", color: Color(0xFF8E4585)),
  ColorData(name: "Cerulean", color: Color(0xFF007BA7)),
  ColorData(name: "Moutarde", color: Color(0xFFFFDB58)),
];

