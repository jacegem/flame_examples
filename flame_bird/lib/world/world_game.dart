import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'dart:math' as math;
import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/box2d/box2d_game.dart';
import 'package:flame/box2d/contact_callbacks.dart';
import 'package:flame/flame.dart';
import 'package:flame/gestures.dart';
import 'package:flame/palette.dart';
import 'package:flame_bird/world/backyard.dart';
import 'package:flame_bird/world/square.dart';
import 'package:flame_bird/world/wall.dart';
import 'package:flutter/material.dart';
import 'package:box2d_flame/box2d.dart';

import 'ball.dart';
import 'bird.dart';

class WorldGame extends Game with TapDetector {
  World world;
  Size size;
  Wall wall;
  List<Ball> balls = [];
  Backyard backyard;
  Bird bird;
  Square square;
  double gravity = 10;
  double scaleX = 10;
  double scaleY;

  WorldGame(this.size) {
    // world = World.withPool(
    //   Vector2(0, 10),
    //   DefaultWorldPool(100, 10),
    // );
    world = World.withGravity(
      Vector2(0, gravity),
    );

    scaleY = size.height / (size.width / scaleX);

    wall = Wall(this);
    backyard = Backyard(this);
    bird = Bird(this);
    square = Square(this, 0.1);
  }

  @override
  void onTapDown(TapDownDetails details) {
    super.onTapDown(details);
    Vector2 position =
        Vector2(details.globalPosition.dx, details.globalPosition.dy);

    print(position);
    // position = Vector2(10, 20);
    // add(Ball(position, box));
    // balls.add(Ball(this, position));
    bird.jump();
  }

  @override
  void render(Canvas c) {
    c.save();
    c.scale(size.width / scaleX, size.height / scaleY);

    backyard.render(c);
    wall.render(c);
    balls.forEach((Ball b) => b.render(c));
    // square.render(c);
    bird.render(c);
    c.restore();
  }

  @override
  void update(double t) {
    if (size == null) {
      return;
    }

    world.stepDt(t, 100, 100);
    balls.forEach((Ball b) => b.update(t));
    square.update(t);
    bird.update(t);
  }
}
