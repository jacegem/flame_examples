import 'dart:ui';
import 'package:flame/palette.dart';
import 'package:flame/box2d/viewport.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:box2d_flame/box2d.dart';

List<Wall> createBoundaries(Box2DComponent box) {
  final Viewport viewport = box.viewport;
  print('${viewport.height}, ${viewport.width}');
  final Vector2 screenSize = Vector2(viewport.width, viewport.height);
  final Vector2 topLeft = (screenSize / 2) * -1;
  final Vector2 bottomRight = screenSize / 2;
  final Vector2 topRight = Vector2(bottomRight.x, topLeft.y);
  final Vector2 bottomLeft = Vector2(topLeft.x, bottomRight.y);

  return [
    Wall(topLeft, topRight, box),
    Wall(topRight, bottomRight, box),
    Wall(bottomRight, bottomLeft, box),
    Wall(bottomLeft, topLeft, box),
  ];
}

class Wall extends BodyComponent {
  Paint paint = BasicPalette.white.paint;
  final Vector2 start;
  final Vector2 end;

  Wall(this.start, this.end, Box2DComponent box) : super(box) {
    _createBody(start, end);
  }

  @override
  void renderPolygon(Canvas canvas, List<Offset> coordinates) {
    final start = coordinates[0];
    final end = coordinates[1];
    // canvas.drawLine(start, end, paint);

    Offset bottomLeft = coordinates[0];
    Offset bottomRight = coordinates[1];
    Offset topRight = coordinates[2];
    Offset topLeft = coordinates[3];

    var rect = Rect.fromLTWH(topLeft.dx, topRight.dy,
        bottomRight.dx - topLeft.dx, bottomLeft.dy - topRight.dy);
    // print(coordinates);
    // var rect = Rect.fromCenter(center: Offset(100, 100), width: 10, height: 10);
    canvas.drawRect(rect, paint);
  }

  void _createBody(Vector2 start, Vector2 end) {
    final PolygonShape shape = PolygonShape();
    // shape.setAsEdge(start, end);

    double hx = 5;
    double hy = 5;
    Vector2 center = Vector2(0, 0);
    double angle = 0;

    shape.setAsBox(hx, hy, center, angle);

    final fixtureDef = FixtureDef()
      ..shape = shape
      ..restitution = 0.0
      ..friction = 0.1;

    final bodyDef = BodyDef()
      ..setUserData(this) // To be able to determine object in collision
      ..position = Vector2.zero()
      ..type = BodyType.STATIC;

    body = world.createBody(bodyDef)..createFixtureFromFixtureDef(fixtureDef);
  }
}
