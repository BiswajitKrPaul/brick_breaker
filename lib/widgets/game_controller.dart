import 'package:brick_breaker/constants/constants.dart';
import 'package:flutter/material.dart';

class GameController extends StatelessWidget {
  final Function function;
  final Direction direction;

  GameController({this.function, this.direction});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        ElevatedButton(
          onPressed: () {
            function(Direction.left);
          },
          child: Icon(
            Icons.arrow_left,
            size: 36,
          ),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(side: BorderSide.none),
            minimumSize: Size(80, 80),
            elevation: 0,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            function(Direction.right);
          },
          child: Icon(
            Icons.arrow_right,
            size: 36,
          ),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(side: BorderSide.none),
            minimumSize: Size(80, 80),
            elevation: 0,
          ),
        ),
      ],
    );
  }
}
