import 'package:boxgame/brick/game/brick_game.dart';
import 'dart:math';
import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:boxgame/brick/game/brick_game.dart';

class Brick {
  BrickGame game;
  Paint paint;
  PolygonShape shape; // for physics
  Path path; // for appearance
  Body body;
  double startX;
  double startY;

  Brick(this.game) {
    double size = 1 / 2;
    List<Vector2> vectors = <Vector2>[
      Vector2(-size, -size),
      Vector2(size, -size),
      Vector2(size, size),
      Vector2(-size, size),
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

    var rnd = Random();
    startX = rnd.nextInt(game.width_scale).toDouble();
    startY = rnd.nextInt(game.height_scale - 4) + 2.0;

    BodyDef bd = BodyDef();
    bd.linearVelocity = Vector2.zero();
    bd.position = Vector2(startX + size, startY + size);
    bd.type = BodyType.STATIC;
    body = game.world.createBody(bd);
    body.userData = this;

    FixtureDef fd = FixtureDef();
    fd.density = 20;
    fd.restitution = 1;
    fd.friction = 0;
    fd.shape = shape;

    Fixture ff = body.createFixtureFromFixtureDef(fd);
    ff.userData = 'brick';
  }

  void render(Canvas c) {
    c.save();
    // c.drawPath(path, paint);
    var rect = Rect.fromLTWH(startX, startY, 1, 1);
    c.drawRect(rect, paint);
    c.restore();
  }
}
