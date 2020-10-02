import 'dart:math';
import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:boxgame/brick/game/brick_game.dart';

class Ball {
  final BrickGame game;
  Body body;
  Paint paint;
  CircleShape shape; // for physics
  Path path; // for appearance

  bool isStarted = false;
  bool isImpulsed = false;

  double angle = 0;
  double offsetX;
  double offsetY;

  Ball(this.game) {
    createBody();
  }

  num degreesToRads(num deg) {
    return (deg * pi) / 180.0;
  }

  void render(Canvas c) {
    // print('${body.position.x}, ${body.position.y}');
    c.save();

    if (isStarted == false) {
      /*
      angle = 0 
      x = sin(angle)
      y = cos(angle)
      */
      offsetX = sin(degreesToRads(angle));
      offsetY = -cos(degreesToRads(angle));
      var x = body.position.x + offsetX;
      var y = body.position.y + offsetY;
      var center = Offset(x, y);
      // var rect = Rect.fromCircle(center: center, radius: .5);

      c.drawCircle(center, .1, paint);
    }

    c.drawCircle(Offset(body.position.x, body.position.y), .25, paint);
    c.restore();
  }

  void update(double t) {
    if (isStarted == false) return;

    if (!isImpulsed) {
      isImpulsed = true;
      MassData data = MassData();
      body.getMassData(data);

      body.applyLinearImpulse(
        Vector2(
          data.mass * offsetX * 10,
          data.mass * offsetY * 10,
        ),
        body.position,
        true,
      );
    }
  }

  void moveRight() {
    Vector2 position = body.position;
    position.x += 1;
    if (position.x >= game.width_scale) {
      position.x = game.width_scale - 1.0;
    }
    body.setTransform(position, 0);
  }

  void moveLeft() {
    Vector2 position = body.position;
    position.x -= 1;
    if (position.x <= 0) {
      position.x = 1;
    }
    body.setTransform(position, 0);
  }

  void destroyBody() {
    game.world.destroyBody(body);
  }

  void createBody() {
    shape = CircleShape();
    shape.p.setFrom(Vector2(0, 0));
    shape.radius = .25;

    paint = Paint();
    paint.color = Color(0xffffffff);

    BodyDef bd = BodyDef();
    bd.linearVelocity = Vector2.zero();
    bd.position = Vector2(
      game.width_scale / 2,
      game.height_scale - 1.0,
    );
    bd.fixedRotation = true;
    bd.type = BodyType.DYNAMIC;
    body = game.world.createBody(bd);
    body.userData = this;

    FixtureDef fd = FixtureDef();
    fd.density = 10;
    fd.restitution = 1;
    fd.friction = 0;
    fd.shape = shape;
    Fixture ff = body.createFixtureFromFixtureDef(fd);
    ff.userData = 'ball';
  }

  void start() {
    if (isStarted == true) {
      isStarted = false;
      isImpulsed = false;
      destroyBody();
      createBody();
    } else {
      isStarted = true;
    }
  }

  void rotateLeft() {
    angle -= 10;
    if (angle <= -90) angle = -80;
  }

  void rotateRight() {
    angle += 10;
    if (angle >= 90) angle = 80;
  }
}
