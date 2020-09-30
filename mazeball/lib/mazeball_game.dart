import 'dart:ui';

import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/box2d/box2d_game.dart';
import 'package:flame/game/game.dart';

import 'ball.dart';

class MazeBallGame extends Box2DGame {
  MazeBallGame(Box2DComponent box) : super(box) {
    add(Ball(box));
  }
}
