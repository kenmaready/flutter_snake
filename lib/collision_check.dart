import './collidable.dart';

bool collisionCheck(Collidable one, Collidable two, double size) {
  final oneLeft = one.x - size / 2;
  final oneRight = one.x + size / 2;
  final oneTop = one.y - size / 2;
  final oneBottom = one.y + size / 2;

  final twoLeft = two.x - size / 2;
  final twoRight = two.x + size / 2;
  final twoTop = two.y - size / 2;
  final twoBottom = two.y + size / 2;

  bool horizontalCrossing = oneRight > twoLeft && oneLeft < twoRight;
  bool verticalCrossing = oneBottom > twoTop && oneTop < twoBottom;

  return (horizontalCrossing && verticalCrossing);
}
