import 'dart:ui';

import 'package:box2d_flame/box2d.dart' hide Timer;
import 'package:flame/palette.dart';

import 'brick2_game.dart';

class VerticalWall {
  final Brick2Game game;
  Body body;

  Paint paint;
  PolygonShape shape; // for physics
  Path path; // for appearance

  VerticalWall(this.game, Vector2 position, double height) {
    double size = game.scale / 100;

    size = 0.5;

    List<Vector2> vectors = <Vector2>[
      Vector2(-.125, height / -2),
      Vector2(.125, height / -2),
      Vector2(.125, height / 2),
      Vector2(-.125, height / 2),
    ];
    shape = PolygonShape();
    shape.set(vectors, vectors.length);

    path = Path();
    path.addPolygon(<Offset>[
      Offset(vectors[0].x, vectors[0].y),
      Offset(vectors[1].x, vectors[1].y),
      Offset(vectors[2].x, vectors[2].y),
      Offset(vectors[3].x, vectors[3].y),
    ], true);

    paint = Paint();
    paint.color = Color(0xffffffff);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = .03;

    FixtureDef fixtureDef = FixtureDef()
      ..density = 20
      ..restitution = 1
      ..friction = 0
      ..shape = shape;

    BodyDef bodyDef = BodyDef()
      ..linearVelocity = Vector2(1, 1)
      ..position = position
      ..type = BodyType.STATIC;

    body = game.world.createBody(bodyDef);
    body.userData = this;

    Fixture ff = body.createFixtureFromFixtureDef(fixtureDef);
    ff.userData = 'wall';
  }

  void render(Canvas c) {
    c.save();
    c.translate(body.position.x, body.position.y);
    c.drawPath(path, paint);

    c.restore();
  }

  void update(double t) {}
}
