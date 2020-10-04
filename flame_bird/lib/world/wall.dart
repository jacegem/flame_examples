import 'dart:ui';

import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:box2d_flame/box2d.dart';
import 'package:flame_bird/world/world_game.dart';

class Wall {
  // static const color = PaletteEntry(Colors.brown);
  static final _brown = const Color(0xFFDDC0A3);
  WorldGame game;
  Color color = Wall._brown;
  Size size;
  Body body;
  PolygonShape shape;

  Wall(this.game) {
    createBody();
  }

  void createBody() {
    double height = 1;
    double width = game.scaleX - 1;

    shape = PolygonShape();
    // List<Vector2> vectors = <Vector2>[
    //   Vector2(-width, height),
    //   Vector2(width, -height),
    //   Vector2(width, height),
    //   Vector2(-width, height),
    // ];
    // shape.set(vectors, vectors.length);
    shape.setAsBoxXY(width / 2, height / 2);

    final fixtureDef = FixtureDef()
      ..shape = shape
      ..restitution = 0
      ..density = 1.0
      ..friction = 1;

    final bodyDef = BodyDef()
      // To be able to determine object in collision
      ..setUserData(this)
      // ..position = Vector2(10, game.scaleY - 1)
      ..position = Vector2(game.scaleX / 2, game.scaleY - 1)
      ..type = BodyType.STATIC;

    body = game.world.createBody(bodyDef)
      ..createFixtureFromFixtureDef(fixtureDef);
  }

  void render(Canvas c) {
    // Paint paint = Paint();
    // paint.color = Color(0xffaabbcc);
    c.save();
    var center = body.worldCenter;
    // print('center : ${body.position.x}, ${center.y}');
    c.translate(center.x, center.y);
    // var rect = Rect.fromLTWH(0, 0, game.scaleX, game.scaleY);
    // var rect = Rect.fromLTWH(0, 0, game.scaleX, 1);
    var rect =
        Rect.fromCenter(center: Offset.zero, width: game.scaleX - 2, height: 1);
    // var rect = Rect.fromLTWH(100, 100, 100, 100);
    c.drawRect(rect, bgColor);
    // Sprite player = Sprite('bird-0.png');
    // player.render(c); //canvas, width, height
    c.restore();
  }

  get bgColor => Paint()..color = color;

  void update(double t) {}
}
