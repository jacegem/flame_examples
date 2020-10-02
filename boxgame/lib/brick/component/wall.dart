import 'dart:ui';
import 'package:box2d_flame/box2d.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

import '../game/brick_game.dart';

enum WallType { top, bottom, left, right }

class Wall extends BodyComponent {
  final BrickGame game;
  Body body;

  PolygonShape shape; // for physics
  Path path; // for appearance
  Vector2 start;
  Vector2 end;
  Paint paint = BasicPalette.white.paint;

  Wall(this.game, WallType type) : super(null) {
    shape = PolygonShape();
    var edge = getEdge(type);
    start = edge[0];
    end = edge[1];

    shape.setAsEdge(start, end);

    // final fixtureDef = FixtureDef()
    //   ..shape = shape
    //   ..restitution = 0.0
    //   ..friction = 0.1;

    // final bodyDef = BodyDef()
    //   ..setUserData(this) // To be able to determine object in collision
    //   ..position = Vector2.zero()
    //   ..type = BodyType.STATIC;

    BodyDef bd = BodyDef();
    bd.linearVelocity = Vector2.zero();
    bd.position = Vector2.zero();
    bd.type = BodyType.STATIC;
    body = game.world.createBody(bd);
    body.userData = this;

    FixtureDef fd = FixtureDef();
    fd.density = 20;
    fd.restitution = 1;
    fd.friction = 0;
    fd.shape = shape;
    Fixture ff = body.createFixtureFromFixtureDef(fd);
    ff.userData = 'wall';
  }

  void render(Canvas c) {
    c.save();

    c.drawLine(Offset(start.x, start.y), Offset(end.x, end.y), paint);
    // c.drawRect(rect, paint);
    c.restore();
  }

  Vector2 getEnd(WallType type) {
    switch (type) {
      case WallType.top:
        return Vector2(game.width_scale.toDouble(), 0);
      case WallType.bottom:
        return Vector2(
            game.width_scale.toDouble(), game.height_scale.toDouble());
      case WallType.left:
        return Vector2(0, game.height_scale.toDouble());
      case WallType.right:
        return Vector2(
            game.width_scale.toDouble(), game.height_scale.toDouble());
    }

    return null;
  }

  List<Vector2> getEdge(WallType type) {
    double width = game.width_scale.toDouble();
    double height = game.height_scale.toDouble();

    switch (type) {
      case WallType.top:
        return [
          Vector2(0, 0),
          Vector2(width, 0),
        ];
      case WallType.bottom:
        return [
          Vector2(0, height),
          Vector2(width, height),
        ];

      case WallType.left:
        return [
          Vector2(0, 0),
          Vector2(0, height),
        ];
      case WallType.right:
        return [
          Vector2(width, 0),
          Vector2(width, height),
        ];
    }

    return null;
  }
}
