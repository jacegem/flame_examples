import 'dart:ui';
import 'package:box2d_simple/brick2/vertical_wall.dart';
import 'package:flame/components/parallax_component.dart';
import 'package:flame/game.dart';
import 'package:box2d_flame/box2d.dart' hide Timer;
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class Brick2Game extends Game implements ContactListener {
  World world;
  Size screenSize;
  // List<Brick> bricks;
  // List<Ball> balls;
  // HorizontalWall topWall;
  // HorizontalWall bottomWall;
  // VerticalWall leftWall;
  VerticalWall rightWall;
  int scale = 10;

  Brick2Game() {
    world = World.withPool(
      Vector2(0, 0),
      DefaultWorldPool(100, 10),
    );
    world.setContactListener(this);
    // world.setContactFilter(this);

    // walls
    // if (topWall == null) {
    //   topWall = HorizontalWall(this, Vector2(0, -7.875), 8.75);
    // }
    // if (bottomWall == null) {
    //   bottomWall = HorizontalWall(this, Vector2(0, 7.875), 8.75);
    // }
    // if (leftWall == null) {
    //   leftWall = VerticalWall(this, Vector2(-4.375, 0), 15.75);
    // }

    rightWall = VerticalWall(this, Vector2(4.375, 0), 15.75);
  }

  @override
  void resize(Size size) {
    screenSize = size;
  }

  @override
  void render(Canvas c) {
    if (screenSize == null) return;
    scale = 10;

    c.save();
    c.translate(screenSize.width / 2, screenSize.height / 2);
    c.scale(screenSize.width / scale);

    double maxWidth = scale / 2;
    double maxHeight = screenSize.height / (screenSize.width / scale) / 2;

    Rect rect = Rect.fromLTWH(0, 0, maxWidth, maxHeight);
    // rect = Rect.fromCenter(center: Offset(0, 0), width: 2, height: 2);

    Paint p = BasicPalette.white.paint;
    Paint paint = Paint();
    paint.color = Color(0xffffffff);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = .03;

    c.drawRect(rect, paint);

    rightWall.render(c);

    c.restore();
  }

  @override
  void update(double t) {
    rightWall.update(t);
  }

  @override
  void beginContact(Contact contact) {
    // if (contact.fixtureA.userData == 'brick') {
    //   (contact.fixtureA.getBody().userData as Brick).impact();
    // }
    // if (contact.fixtureB.userData == 'brick') {
    //   (contact.fixtureB.getBody().userData as Brick).impact();
    // }
  }

  @override
  void endContact(Contact contact) {
    // TODO: implement endContact
  }

  @override
  void postSolve(Contact contact, ContactImpulse impulse) {
    // TODO: implement postSolve
  }

  @override
  void preSolve(Contact contact, Manifold oldManifold) {
    // TODO: implement preSolve
  }
}
