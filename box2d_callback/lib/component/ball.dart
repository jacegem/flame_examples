import 'dart:math' as math;

import 'package:box2d_flame/box2d.dart';

import 'dart:ui';

import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class Ball extends BodyComponent {
  Paint originalPaint, currentPaint;
  bool giveNudge = false;
  int _life = 3;

  Ball(Vector2 position, Box2DComponent box) : super(box) {
    originalPaint = _randomPaint();
    currentPaint = originalPaint;
    final worldPosition = viewport.getScreenToWorld(position);
    _createBody(5.0, worldPosition);
  }

  Paint _randomPaint() {
    final rng = math.Random();
    return PaletteEntry(
      Color.fromARGB(
        100 + rng.nextInt(155),
        100 + rng.nextInt(155),
        100 + rng.nextInt(155),
        255,
      ),
    ).paint;
  }

  void _createBody(double radius, Vector2 position) {
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
      ..linearVelocity = Vector2(10, 20)
      ..type = BodyType.DYNAMIC;

    body = world.createBody(bodyDef)..createFixtureFromFixtureDef(fixtureDef);
  }

  @override
  bool destroy() {
    // Implement your logic for when the component should be removed
    if (_life < 0) {
      return true;
    }
    return false;
  }

  void lifeDown() {
    _life -= 1;

    if (_life < 0) {
      this.destroy();
    }
  }

  @override
  void renderCircle(Canvas c, Offset p, double radius) {
    final blue = const PaletteEntry(Colors.blue).paint;
    c.drawCircle(p, radius, currentPaint);

    final angle = body.getAngle();
    final lineRotation =
        Offset(math.sin(angle) * radius, math.cos(angle) * radius);
    c.drawLine(p, p + lineRotation, blue);
  }

  @override
  void update(double t) {
    super.update(t);
    if (giveNudge) {
      body.applyLinearImpulse(Vector2(0, 10000), body.getLocalCenter(), true);
      giveNudge = false;
    }
  }
}
