import 'package:flutter/material.dart';
import 'package:flutter_snake/collision_check.dart';
//
import './collidable.dart';
import './direction.dart';
import './food.dart';

class SnakePiece implements Collidable {
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

  void addPiece() {
    double newPieceX = pieces.last.x;
    double newPieceY = pieces.last.y;

    switch (direction) {
      case Direction.Up:
        newPieceY += gridSize;
        break;
      case Direction.Right:
        newPieceX -= gridSize;
        break;
      case Direction.Down:
        newPieceY -= gridSize;
        break;
      case Direction.Left:
        newPieceX += gridSize;
        break;
    }

    pieces.add(SnakePiece(x: newPieceX, y: newPieceY));
  }

  bool isEating(Food food) {
    return collisionCheck(pieces[0], food, gridSize);
  }
}
