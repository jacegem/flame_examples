import 'dart:ui';
import 'package:box2d_flame/box2d.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math;

class Ball extends BodyComponent {
  Paint originalPaint, currentPaint;

  Paint paint;
//Size of the screen from the resize event
  Size screenSize;
//Rectangle based on the size, easy to use
  Rect _screenRect;
  final int scale = 5;

  //Initial acceleration -> no movement as its (0,0)
  Vector2 acceleration = Vector2.zero();

  Ball(Vector2 position, Box2DComponent box) : super(box) {
    originalPaint = _randomPaint();
    currentPaint = originalPaint;

    final worldPosition = viewport.getScreenToWorld(position);
    // _createBody(5.0, worldPosition);
    print('position: $position');
    print('worldPosition: $worldPosition');

    _create2(worldPosition);
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

  void _create2(Vector2 position) {
    CircleShape shape = CircleShape(); //build in shape, just set the radius
    shape.p.setFrom(Vector2.zero());
    shape.radius = 10; //10cm ball

    paint = Paint();
    paint.color = Color(0xffff00ff);

    BodyDef bd = BodyDef();
    bd.linearVelocity = Vector2.zero();
    bd.position = position;
    bd.fixedRotation = false;
    bd.bullet = false;
    bd.type = BodyType.DYNAMIC;
    body = world.createBody(bd);
    body.userData = this;

    FixtureDef fd = FixtureDef();
    fd.density = 10;
    fd.restitution = 1;
    fd.friction = 0;
    fd.shape = shape;
    body.createFixtureFromFixtureDef(fd);

    // body = world.createBody(bd)..createFixtureFromFixtureDef(fd);
    //Link to the sensor using dart Stream
    // gyroscopeEvents.listen((GyroscopeEvent event) {
    //   //Adding up the scaled sensor data to the current acceleration
    //   acceleration.add(Vector2(event.y / sensorScale, event.x / sensorScale));
    // });
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
      // ..linearVelocity = Vector2(10, 20)
      ..type = BodyType.DYNAMIC;

    body = world.createBody(bodyDef)..createFixtureFromFixtureDef(fixtureDef);
  }

  @override
  void resize(Size size) {
    print('size: $size');

    paint = Paint();
    paint.color = Color(0xffffffff);
    //Store size and related rectangle
    screenSize = size;
    _screenRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    super.resize(size);
  }

  // @override
  // void renderCircle(Canvas c, Offset p, double radius) {
  //   print('renderCircle: $c');

  //   final blue = const PaletteEntry(Colors.blue).paint;
  //   c.drawCircle(p, radius, currentPaint);

  //   final angle = body.getAngle();
  //   final lineRotation =
  //       Offset(math.sin(angle) * radius, math.cos(angle) * radius);
  //   c.drawLine(p, p + lineRotation, blue);
  // }

  //Draw the ball
  void render(Canvas c) {
    print('render: $c');

    c.save();
    //Move the canvas point 0,0 to the top left edge of our ball
    c.translate(body.position.x, body.position.y);
    print('${body.position.x}, ${body.position.y}');
    //Simply draw the circle
    c.drawCircle(Offset(0, 0), .1, paint);
    c.restore();
  }

  void update(double t) {
    //Our ball has to move, every frame by its accelartion. If frame rates drop it will move slower...
    body.applyForceToCenter(acceleration);
  }
}
