import 'dart:ui';
import 'dart:math';

import 'package:box2d_flame/box2d.dart';
import 'package:boxgame/brick/game/brick_game.dart';

class Goal {
  final BrickGame game;
  Body body;
  Paint paint;
  CircleShape shape; // for physics
  Path path; // for appearance

  Goal(this.game) {
    createBody();
  }

  void createBody() {
    shape = CircleShape();
    shape.p.setFrom(Vector2(0, 0));
    shape.radius = .25;

    paint = Paint();
    paint.color = Color(0xfff00fff);

    BodyDef bd = BodyDef();
    bd.linearVelocity = Vector2.zero();
    bd.position = Vector2(game.width_scale / 2, 1);
    bd.fixedRotation = true;
    bd.bullet = true;
    bd.type = BodyType.STATIC;
    body = game.world.createBody(bd);
    body.userData = this;

    FixtureDef fd = FixtureDef();
    fd.density = 10;
    fd.restitution = 1;
    fd.friction = 0;
    fd.shape = shape;
    Fixture ff = body.createFixtureFromFixtureDef(fd);
    ff.userData = 'goal';
  }

  void render(Canvas c) {
    // print('${body.position.x}, ${body.position.y}');
    c.save();
    c.drawCircle(Offset(body.position.x, body.position.y), .25, paint);
    c.restore();
  }

  void touch() {
    print('touch');
  }
}
