import 'dart:math' as math;
import 'package:box2d_callback/component/white_ball.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/box2d/box2d_game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'package:box2d_flame/box2d.dart';
import 'component/ball.dart';
import 'contact/ball_contact_callback.dart';
import 'component/wall.dart';
import 'contact/ball_wall_contact_callback.dart';
import 'contact/white_ball_contact_callback.dart';

class MyGame extends Box2DGame with TapDetector {
  MyGame(Box2DComponent box) : super(box) {
    final boundaries = createBoundaries(box);
    boundaries.forEach(add);
    addContactCallback(BallContactCallback());
    addContactCallback(BallWallContactCallback());
    addContactCallback(WhiteBallContactCallback());
  }

  @override
  void onTapDown(TapDownDetails details) {
    super.onTapDown(details);
    final Vector2 position =
        Vector2(details.globalPosition.dx, details.globalPosition.dy);
    if (math.Random().nextInt(10) < 2) {
      add(WhiteBall(position, box));
    } else {
      add(Ball(position, box));
    }
  }
}
