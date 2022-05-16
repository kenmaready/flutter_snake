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
  Timer timer = Timer(const Duration(milliseconds: 1), () {});
  late double width;
  late double height;
  late double gridSize;
  int speed = 1;
  int score = 0;

  void update() {
    snake.advance();
    if (snake.isEating(food)) {
      score += 10;
      food = Food.spawn(
          screenHeight: height, screenWidth: width, gridSize: gridSize);
      snake.addPiece();
      speed += 1;
      print("Speed is now $speed");
      setTimer();
    }
    if (snake.hitItself()) {
      print("D'oh! Hit myself!");
      startGame();
    }
    setState(() {});
  }

  void setTimer() {
    timer.cancel();
    timer = Timer.periodic(
        Duration(milliseconds: 210 - (10 * speed)), (timer) => update());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    startGame();
  }

  void startGame() {
    final screenSize = MediaQuery.of(context).size;
    final appBarHeight = AppBar().preferredSize.height;
    width = screenSize.width;
    height = screenSize.height - appBarHeight;
    gridSize = width / 20;
    score = 0;
    speed = 1;
    snake = Snake(
        startingX: width / 2,
        startingY: height / 2,
        direction: Direction.Up,
        gridSize: gridSize,
        screenWidth: width,
        screenHeight: height);
    food = Food.spawn(
        screenHeight: height, screenWidth: width, gridSize: gridSize);
    setTimer();
    setState(() {});
    print("Speed is now $speed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Score $score")),
        body: Container(
            color: Theme.of(context).colorScheme.background,
            child: snake != null
                ? Stack(children: [
                    ...snake.draw(),
                    food.draw(),
                    ControlPanel(onPressed: snake.changeDirection)
                  ])
                : const CircularProgressIndicator()));
  }
}
