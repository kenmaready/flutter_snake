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

  bool horizontalCrossing =
      oneRight - 0.001 > twoLeft && oneLeft + 0.001 < twoRight;
  bool verticalCrossing =
      oneBottom - 0.001 > twoTop && oneTop + 0.001 < twoBottom;
  print(
      "one: [$oneTop, $oneRight, $oneBottom, $oneLeft], two: [$twoTop, $twoRight, $twoBottom, $twoLeft]");
  print(
      "horizontalCrossing: ${horizontalCrossing.toString()}, verticalCrossing: ${verticalCrossing.toString()}");

  return (horizontalCrossing && verticalCrossing);
}
