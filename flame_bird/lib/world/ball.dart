import 'dart:ui';

import 'package:flame/animation.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'dart:math' as math;
import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/box2d/box2d_game.dart';
import 'package:flame/box2d/contact_callbacks.dart';
import 'package:flame/flame.dart';
import 'package:flame/gestures.dart';
import 'package:flame/palette.dart';
import 'package:flame/position.dart' as fpos;
import 'package:flame/sprite.dart';
import 'package:flame_bird/world/world_game.dart';
// import 'package:flutter/material.dart';
import 'package:box2d_flame/box2d.dart';

class Ball {
  WorldGame game;
  Body body;
  Sprite bird;
  Animation b;

  static const SIZE = 52.0;

  Ball(this.game, Vector2 position) {
    // final worldPosition = viewport.getScreenToWorld(position);
    createBody(SIZE / 2, position);
    bird = Sprite('bird-0.png');

    b = Animation.sequenced(
      'bird.png',
      4,
      textureWidth: 16.0,
      textureHeight: 16.0,
    );
  }

  void createBody(radius, position) {
    final CircleShape shape = CircleShape();
    shape.radius = radius;

    final fixtureDef = FixtureDef()
      ..shape = shape
      ..restitution = 1.0
      ..density = 1.0
      ..friction = 0.1;

    final bodyDef = BodyDef()
      // To be able to determine object in collision
      ..setUserData(this)
      ..position = position
      ..type = BodyType.DYNAMIC;

    body = game.world.createBody(bodyDef)
      ..createFixtureFromFixtureDef(fixtureDef);
  }

  void render(Canvas c) async {
    var paint = Paint();
    paint.color = Color(0xfff00fff);

    c.save();

    var rect = Rect.fromLTWH(
      body.position.x,
      body.position.y,
      100,
      100,
    );
    // bird.renderRect(c, rect); //canvas, width, height
    var pos = fpos.Position(body.position.x, body.position.y);
    b.getSprite().renderCentered(c, pos, size: fpos.Position(SIZE, SIZE));
    // paintImage(
    //     canvas: c,
    //     image: image,
    //     rect: new Rect.fromCircle(center: center, radius: radius),
    //     flipHorizontally: !this.forward,
    //     fit: BoxFit.contain);

    c.restore();
  }

  void update(double t) {
    b.update(t);

    MassData data = MassData();
    body.getMassData(data);

    body.applyLinearImpulse(
      Vector2(
        data.mass * 0,
        data.mass * 0,
      ),
      body.position,
      true,
    );
  }

  // @override
  // void renderCircle(Canvas c, Offset p, double radius) {
  //   Paint paint = Paint()..color = Colors.redAccent;

  //   final blue = const PaletteEntry(Colors.blue).paint;
  //   c.drawCircle(p, radius, paint);

  //   final angle = body.getAngle();
  //   final lineRotation =
  //       Offset(math.sin(angle) * radius, math.cos(angle) * radius);
  //   c.drawLine(p, p + lineRotation, blue);
  // }
}
