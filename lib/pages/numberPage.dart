import 'package:flutter/material.dart';

import '../components/_backButton.dart';
import '../components/_background.dart';
import '../services/datas.dart';

class NumberPage extends StatefulWidget {
  final int option; // 3 pour 1 à 10, 4 pour 1 à 100

  const NumberPage({super.key, required this.option});

  @override
  _NumberPageState createState() => _NumberPageState();
}

class _NumberPageState extends State<NumberPage> {
  late List<NumberData> numbers;
  final PageController _pageController = PageController();

  void _nextPage() {
    if (_pageController.page! < (numbers.length / 2).ceil() - 1) {
      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  void _previousPage() {
    if (_pageController.page! > 0) {
      _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  @override
  void initState() {
    super.initState();
    numbers = generateNumbers(widget.option == 3 ? 10 : 100);
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
                  widget.option == 3
                      ? 'Les chiffres de 1 à 10 avec nous'
                      : 'Les chiffres de 1 à 100 avec nous',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenHeight * 0.04,
                    color: Colors.orange,
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: (numbers.length / 2).ceil(),
                    itemBuilder: (context, pageIndex) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(2, (index) {
                          int numberIndex = pageIndex * 2 + index;
                          if (numberIndex >= numbers.length) return Container();
                          return Column(
                            children: [
                              Container(
                                width: screenHeight * 0.15,
                                height: screenHeight * 0.15,
                                decoration: BoxDecoration(
                                  color: numbers[numberIndex].color,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    numbers[numberIndex].number.toString(),
                                    style: TextStyle(
                                      fontSize: screenHeight * 0.08,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                numbers[numberIndex].number.toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          );
                        }),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_left, size: screenHeight * 0.15, color: Colors.orange),
                      onPressed: _previousPage,
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_right, size: screenHeight * 0.15, color: Colors.orange),
                      onPressed: _nextPage,
                    ),
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
