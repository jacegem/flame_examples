import 'dart:ui';
import 'package:box2d_flame/box2d.dart' hide Position;
import 'package:flame/anchor.dart';
import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/position.dart';
import 'package:flame_bird/world/world_game.dart';
import 'package:flutter/material.dart' hide Animation;

class Bird {
  WorldGame game;
  Animation ani;
  double angle = 0;
  Body body;
  static const SIZE = 52.0;
  static const SPEED = 0.25;
  static const textureWidth = 16.0;

  Bird(this.game) {
    ani = Animation.sequenced(
      'bird.png',
      4,
      textureWidth: 16.0,
      textureHeight: 16.0,
    );

    // width = SIZE;
    // height = SIZE;
    // angle = 0;
    // var position = Position(game.size.width / 2, game.size.height / 2);
    // setByPosition(position);

    var pos = Vector2(game.size.width / 2, game.size.height / 2);
    createBody(1.0, pos);
  }

  void createBody(double radius, position) {
    final CircleShape shape = CircleShape();
    shape.radius = radius;

    final fixtureDef = FixtureDef()
      ..shape = shape
      ..restitution = 0
      ..density = 1.0
      ..friction = 0.1;

    final bodyDef = BodyDef()
      // To be able to determine object in collision
      ..setUserData(this)
      ..position = Vector2(game.scaleX / 2, 2)
      ..type = BodyType.DYNAMIC;

    body = game.world.createBody(bodyDef)
      ..createFixtureFromFixtureDef(fixtureDef);
  }

  void render(Canvas c) {
    // prepareCanvas(c);
    c.save();
    var center = body.worldCenter;
    print('bird center : ${body.position.x}, ${center.y}');
    c.translate(center.x, center.y);
    c.rotate(angle * 2);

    var paint = Paint()..color = Colors.red;
    c.drawCircle(Offset.zero, 1, paint);

    // var pos = Position(body.position.x, body.position.y);
    var pos = Position(0, 0);
    ani?.getSprite()?.renderCentered(c, pos, size: Position(2, 2));

    // var rect =
    //     Rect.fromCenter(center: Offset.zero, width: game.scaleX - 2, height: 1);
    // var rect = Rect.fromLTWH(100, 100, 100, 100);
    // var bgColor = Paint()..color = Colors.red;
    // c.drawRect(rect, bgColor);
    // var rect = Rect.fromLTWH(body.position.x, body.position.y, SIZE, SIZE);
    // print(rect);
    // ani.getSprite().renderRect(c, rect);
    // var v = body.linearVelocity;
    c.restore();
  }

  void reset() {
    var pos = Vector2(game.size.width / 2, game.size.height / 2);
    body.setTransform(pos, 0);

    angle = 0;
  }

  @override
  void update(double t) {
    ani?.update(t);
    angle = body.linearVelocity.g / 50;
    print(angle);
    // angle += t * SPEED;

    // if (angle > 3) {
    //   angle = 0;
    // }

    if (body.position.y >= game.size.height) {
      reset();
    }
  }

  void jump() {
    // angle -= SPEED;

    body.linearVelocity = Vector2.zero();

    MassData data = MassData();
    body.getMassData(data);

    var impulse = Vector2(
      data.mass * 0,
      data.mass * -game.world.getGravity().y,
    );
    body.applyLinearImpulse(impulse, body.worldCenter, true);
  }
}
