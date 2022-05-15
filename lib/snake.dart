import 'package:flutter/material.dart';
//
import './direction.dart';

class SnakePiece {
  double x;
  double y;
  bool head;

  SnakePiece({required this.x, required this.y, this.head = false});
}

class Snake {
  List<SnakePiece> pieces = [];
  Direction direction;
  double gridSize;
  double screenWidth;
  double screenHeight;

  Snake(
      {required double startingX,
      required double startingY,
      required this.direction,
      required this.gridSize,
      required this.screenWidth,
      required this.screenHeight}) {
    pieces.add(SnakePiece(x: startingX, y: startingY, head: true));
    // for testing only:
    pieces.add(SnakePiece(x: startingX, y: startingY + gridSize));
    pieces.add(SnakePiece(x: startingX, y: startingY + 2 * gridSize));

    print("New Snake initialized...");
  }

  void advance() {
    for (int i = pieces.length - 1; i > 0; i--) {
      pieces[i].x = pieces[i - 1].x;
      pieces[i].y = pieces[i - 1].y;
    }

    switch (direction) {
      case Direction.Up:
        pieces[0].y -= gridSize;
        if (pieces[0].y < 0) {
          pieces[0].y = screenHeight + pieces[0].y;
        }
        break;
      case Direction.Right:
        pieces[0].x += gridSize;
        if (pieces[0].x > screenWidth) {
          pieces[0].x = pieces[0].x - screenWidth;
        }
        break;
      case Direction.Down:
        pieces[0].y += gridSize;
        if (pieces[0].y > screenHeight) {
          pieces[0].y = pieces[0].y - screenHeight;
        }
        break;
      case Direction.Left:
        pieces[0].x -= gridSize;
        if (pieces[0].x < 0) {
          pieces[0].x = screenWidth + pieces[0].x;
        }
    }
  }

  List<Widget> draw() {
    return pieces
        .map((piece) => Positioned(
            height: gridSize,
            width: gridSize,
            left: piece.x - gridSize / 2,
            top: piece.y - gridSize / 2,
            child: CircleAvatar(
              backgroundColor:
                  piece.head ? Colors.orange : Colors.lightBlue.shade500,
            )))
        .toList();
  }

  void changeDirection(Direction newDirection) {
    direction = newDirection;
  }
}
