import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/box2d/box2d_game.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:box2d_flame/box2d.dart';

import 'bg.dart';
import 'bird.dart';

class BoxGame extends Game {
  World world;
  Bg background;
  Bird bird;
  Size size;

  BoxGame(this.size) {
    world = World.withPool(
      Vector2(0, 0),
      DefaultWorldPool(100, 10),
    );

    background = Bg(this);
    bird = Bird(this);
  }

  @override
  void render(Canvas c) {
    background.render(c);
    bird.render(c);
  }

  @override
  void update(double t) {
    bird.update(t);
  }
}
