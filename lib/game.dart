import 'package:flutter/material.dart';
import 'dart:async';
//
import './control_panel.dart';
import './direction.dart';
import './snake.dart';
import './food.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  late Snake snake;
  late Food food;
  late Timer timer;
  late double width;
  late double height;
  late double gridSize;

  void update() {
    snake.advance();
    print("timer...");
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    startGame();
  }

  void startGame() {
    final screenSize = MediaQuery.of(context).size;
    width = screenSize.width;
    height = screenSize.height;
    gridSize = width / 20;
    snake = Snake(
        startingX: width / 2,
        startingY: height / 2,
        direction: Direction.Up,
        gridSize: gridSize,
        screenWidth: width,
        screenHeight: height);
    food = Food.spawn(
        screenHeight: height, screenWidth: width, gridSize: gridSize);
    timer =
        Timer.periodic(const Duration(milliseconds: 200), (timer) => update());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).colorScheme.background,
        child: snake != null
            ? Stack(children: [
                ...snake.draw(),
                food.draw(),
                ControlPanel(onPressed: snake.changeDirection)
              ])
            : CircularProgressIndicator());
  }
}
