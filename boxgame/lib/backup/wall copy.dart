// import 'dart:ui';
// import 'package:box2d_flame/box2d.dart';
// import 'package:flutter/material.dart';

// import '../brick/game/brick_game.dart';

// enum WallType { top, bottom, left, right }

// class Wall {
//   final BrickGame game;
//   Body body;
//   Paint paint;
//   PolygonShape shape; // for physics
//   Path path; // for appearance

//   Wall(this.game, WallType type) {
//     List<Vector2> vectors = getVectors(type);
//     Vector2 position = getPosition(type);

//     shape = PolygonShape();
//     shape.set(vectors, vectors.length);

//     path = Path();
//     path.addPolygon(<Offset>[
//       Offset(vectors[0].x, vectors[0].y),
//       Offset(vectors[1].x, vectors[1].y),
//       Offset(vectors[2].x, vectors[2].y),
//       Offset(vectors[3].x, vectors[3].y),
//     ], true);

//     paint = Paint();
//     paint.color = Color(0xffffffff);
//     paint.style = PaintingStyle.stroke;
//     paint.strokeWidth = .03;

//     BodyDef bd = BodyDef();
//     bd.linearVelocity = Vector2.zero();
//     // bd.position = Vector2(0, -(width / 2));
//     bd.position = position;
//     bd.type = BodyType.STATIC;
//     body = game.world.createBody(bd);
//     body.userData = this;

//     FixtureDef fd = FixtureDef();
//     fd.density = 20;
//     fd.restitution = 1;
//     fd.friction = 0;
//     fd.shape = shape;
//     Fixture ff = body.createFixtureFromFixtureDef(fd);
//     ff.userData = 'wall';
//   }

//   getPosition(type) {
//     switch (type) {
//       case WallType.top:
//         return Vector2(game.scale / 2, 1 / 2);
//       case WallType.bottom:
//         return Vector2(game.scale / 2, game.scale - 1 / 2);
//       case WallType.left:
//         return Vector2(1 / 2, game.scale / 2);
//       case WallType.right:
//         return Vector2(game.scale - 1 / 2, game.scale / 2);
//     }
//   }

//   getVectors(WallType type) {
//     switch (type) {
//       case WallType.top:
//       case WallType.bottom:
//         double width = game.scale.toDouble();
//         double height = 1 / 2;

//         return <Vector2>[
//           Vector2(-width / 2, -height),
//           Vector2(width / 2, -height),
//           Vector2(width / 2, height),
//           Vector2(-width / 2, height),
//         ];
//       case WallType.left:
//       case WallType.right:
//         double height = game.scale.toDouble();
//         double width = 1 / 2;

//         return <Vector2>[
//           Vector2(-width, -height / 2),
//           Vector2(width, -height / 2),
//           Vector2(width, height / 2),
//           Vector2(-width, height / 2),
//         ];
//       default:
//         return null;
//     }
//   }

//   void render(Canvas c) {
//     c.save();

//     c.translate(body.position.x, body.position.y);

//     c.drawPath(path, paint);
//     // c.drawRect(rect, paint);
//     c.restore();
//   }
// }
