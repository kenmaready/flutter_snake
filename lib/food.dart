import 'package:flutter/material.dart';
import 'dart:math';

class Food {
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
    this.y = (_random.nextDouble() * screenHeight).round() * 1.0;
  }

  Widget draw() {
    return Positioned(
        height: gridSize,
        width: gridSize,
        left: x - gridSize / 2,
        top: y - gridSize / 2,
        child: CircleAvatar(
          backgroundColor: Colors.yellowAccent,
        ));
  }
}