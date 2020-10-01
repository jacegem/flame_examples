import 'dart:ui';
import 'package:box2d_flame/box2d.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/box2d/box2d_game.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/gestures.dart';
import 'package:mazeball/screen/center_ball.dart';

import 'ball.dart';

class MazeBallGame extends Box2DGame with TapDetector {
  Ball ball;
  MazeBallGame(Box2DComponent box, Size size) : super(box) {
    // ball = Ball(Vector2(size.width / 2, size.height / 2), box);
    // add(ball);
    add(CenterBall(box));
  }

  @override
  void onTapDown(TapDownDetails details) {
    super.onTapDown(details);
    final Vector2 position =
        Vector2(details.globalPosition.dx, details.globalPosition.dy);

    // add(Ball(position, box));
    // ball.moveTo(position);
  }
}
