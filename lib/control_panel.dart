import 'package:flutter/material.dart';
//
import './direction.dart';

const double ICONSIZE = 48.0;
const double BUTTONSIZE = ICONSIZE + 36.0;

class ControlButton extends StatelessWidget {
  final Direction direction;
  final double x;
  final double y;
  Function onPressed;

  ControlButton(
      {Key? key,
      required this.direction,
      required this.x,
      required this.y,
      required this.onPressed})
      : super(key: key);

  IconData get _icon {
    switch (direction) {
      case Direction.Up:
        return Icons.expand_less_rounded;
      case Direction.Right:
        return Icons.navigate_next_rounded;
      case Direction.Down:
        return Icons.expand_more_rounded;
      case Direction.Left:
        return Icons.navigate_before_rounded;
      default:
        return Icons.error_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: y,
        left: x,
        child: RawMaterialButton(
          onPressed: () => onPressed(direction),
          elevation: 0.0,
          fillColor: Colors.grey.withOpacity(0.6),
          child: Icon(_icon, size: ICONSIZE, color: Colors.white),
          shape: const CircleBorder(),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ));
  }
}

class ControlPanel extends StatelessWidget {
  final Function onPressed;

  const ControlPanel({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final appBarHeight = AppBar().preferredSize.height;
    print("AppBar() height: $appBarHeight");
    final height = deviceSize.height - appBarHeight;
    final width = deviceSize.width;
    final panelCenterX = width / 2;
    final panelCenterY = height * .85;
    final panelButtonXOffset = width / 4;
    final panelButtonYOffset = height / 16;

    return Stack(children: [
      ControlButton(
        direction: Direction.Up,
        x: panelCenterX - BUTTONSIZE / 2,
        y: panelCenterY - panelButtonYOffset - BUTTONSIZE / 2,
        onPressed: onPressed,
      ),
      ControlButton(
        direction: Direction.Right,
        x: panelCenterX + panelButtonXOffset - BUTTONSIZE / 2,
        y: panelCenterY - BUTTONSIZE / 2,
        onPressed: onPressed,
      ),
      ControlButton(
        direction: Direction.Down,
        x: panelCenterX - BUTTONSIZE / 2,
        y: panelCenterY + panelButtonYOffset - BUTTONSIZE / 2,
        onPressed: onPressed,
      ),
      ControlButton(
        direction: Direction.Left,
        x: panelCenterX - panelButtonXOffset - BUTTONSIZE / 2,
        y: panelCenterY - BUTTONSIZE / 2,
        onPressed: onPressed,
      ),
    ]);
  }
}
