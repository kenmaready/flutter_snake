import 'package:flutter/material.dart';
import 'dart:math';
//
import './collidable.dart';

class Food implements Collidable {
  final double screenHeight;
  final double screenWidth;
  final double gridSize;
  late double x;
  late double y;

  Food.spawn({
    required this.screenHeight,
    required this.screenWidth,
    required this.gridSize,
  }) {
    final _random = new Random();
    this.x = (_random.nextDouble() * screenWidth).round() * 1.0;
    this.y =
        (_random.nextDouble() * (screenHeight - AppBar().preferredSize.height))
                .round() *
            1.0;
    print("New Food spawning at [$x, $y]...");
  }

  Widget draw() {
    return Positioned(
        height: gridSize,
        width: gridSize,
        left: x - gridSize / 2,
        top: y - gridSize / 2,
        child: const CircleAvatar(
          backgroundColor: Colors.yellowAccent,
        ));
  }
}
