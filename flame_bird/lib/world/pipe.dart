import 'dart:ui';

import 'package:flame_bird/world/world_game.dart';
import 'package:box2d_flame/box2d.dart';
import 'package:flutter/material.dart';

class Pipe {
  WorldGame game;
  Size size;
  Body body;
  PolygonShape shape;

  double width;
  double height;
  Vector2 center;

  Pipe(this.game) {
    height = 2;
    width = 1;
    center = Vector2(7, 7);

    createBody();
  }

  void createBody() {
    shape = PolygonShape();
    shape.setAsBoxXY(width / 2, height / 2);

    final fixtureDef = FixtureDef()
      ..shape = shape
      ..restitution = 0
      ..density = 1.0
      ..friction = 1;

    final bodyDef = BodyDef()
      // To be able to determine object in collision
      ..setUserData(this)
      ..position = center
      ..type = BodyType.STATIC;

    body = game.world.createBody(bodyDef)
      ..createFixtureFromFixtureDef(fixtureDef);
  }

  void render(Canvas c) {
    c.save();
    var center = body.worldCenter;
    c.translate(center.x, center.y);
    var rect =
        Rect.fromCenter(center: Offset.zero, width: width, height: height);
    var paint = Paint()..color = Colors.green;
    c.drawRect(rect, paint);
    // Sprite player = Sprite('bird-0.png');
    // player.render(c); //canvas, width, height
    c.restore();
  }

  void update(double t) {
    var center = body.worldCenter;
    center.x -= 0.1;
    body.setTransform(center, 0);
  }
}
