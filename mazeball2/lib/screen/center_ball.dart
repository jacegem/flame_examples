import 'dart:ui';
import 'package:box2d_flame/box2d.dart';
import 'package:flame/box2d/box2d_component.dart';

class CenterBall extends BodyComponent {
  CenterBall(Box2DComponent box) : super(box) {
    double radius = 10;
    Vector2 position = Vector2(200, 200);
    final worldPosition = viewport.getScreenToWorld(position);

    final CircleShape shape = CircleShape();
    shape.radius = radius;

    final fixtureDef = FixtureDef()
      ..shape = shape
      ..restitution = 1.0
      ..density = 1.0
      ..friction = 0.1;

    BodyDef bodyDef = BodyDef()
      // To be able to determine object in collision
      ..setUserData(this)
      ..position = position
      // ..linearVelocity = Vector2(10, 20)
      ..type = BodyType.DYNAMIC;

    body = world.createBody(bodyDef)..createFixtureFromFixtureDef(fixtureDef);
  }

  Paint paint;
//Size of the screen from the resize event
  Size screenSize;
//Rectangle based on the size, easy to use
  Rect _screenRect;

  void render(Canvas c) {
    print('render: $c');

    c.save();
    //Move the canvas point 0,0 to the top left edge of our ball
    c.translate(body.position.x, body.position.y);
    print('${body.position.x}, ${body.position.y}');
    //Simply draw the circle
    // c.drawCircle(Offset(0, 0), .1, paint);
    c.restore();
  }

  void update(double t) {}

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
}
