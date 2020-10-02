import 'package:boxgame/brick/game/brick_game.dart';
import 'package:flutter/material.dart';

class GameController extends StatelessWidget {
  final game;

  GameController(this.game);

  Widget build(BuildContext context) {
    double size = 40;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // big empty space
        Spacer(),

        // the bottom part
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              child: Container(
                height: 48,
                width: 48,
                color: Color(0xffffffff),
                child: Center(
                  child: Icon(Icons.keyboard_arrow_left, size: 32),
                ),
              ),
              onPanDown: game.onLeftDragStart,
              // onPanEnd: game.onLeftDragEnd,
            ),
            GestureDetector(
              child: Container(
                height: 48,
                width: 48,
                color: Color(0xffffffff),
                child: Center(
                  child: Icon(Icons.keyboard_arrow_right, size: 32),
                ),
              ),
              onPanDown: game.onRightDragStart,
              // onPanEnd: game.onRightDragEnd,
            ),
            GestureDetector(
              child: Container(
                height: 48,
                width: 48,
                color: Color(0xffffffff),
                child: Center(
                  child: Icon(Icons.fireplace, size: 32),
                ),
              ),
              onTap: game.onStart,
            ),
            GestureDetector(
              child: Container(
                height: 48,
                width: 48,
                color: Color(0xffffffff),
                child: Center(
                  child: Icon(Icons.rotate_left, size: 32),
                ),
              ),
              onTap: game.onRotateLeft,
            ),
            GestureDetector(
              child: Container(
                height: 48,
                width: 48,
                color: Color(0xffffffff),
                child: Center(
                  child: Icon(Icons.rotate_right, size: 32),
                ),
              ),
              onTap: game.onRotateRight,
            ),
          ],
        ),

        // bottom spacer
        SizedBox(height: 18),
      ],
    );
  }
}
