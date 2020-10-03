import 'dart:ui';
import 'package:box2d_flame/box2d.dart' hide Position;
import 'package:flame/anchor.dart';
import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/position.dart';
import 'package:flame_bird/world/world_game.dart';

class Bird {
  WorldGame game;
  Animation ani;
  double angle = 0;
  Body body;
  static const SIZE = 52.0;
  static const SPEED = 0.25;
  static const textureWidth = 16.0;

  Bird(this.game) {
    ani = Animation.sequenced(
      'bird.png',
      4,
      textureWidth: 16.0,
      textureHeight: 16.0,
    );

    // width = SIZE;
    // height = SIZE;
    // angle = 0;
    // var position = Position(game.size.width / 2, game.size.height / 2);
    // setByPosition(position);

    var pos = Vector2(game.size.width / 2, game.size.height / 2);
    createBody(SIZE / 2, pos);
  }

  void createBody(radius, position) {
    final CircleShape shape = CircleShape();
    shape.radius = radius;

    final fixtureDef = FixtureDef()
      ..shape = shape
      ..restitution = 1.0
      ..density = 99.0
      ..friction = 0.1;

    final bodyDef = BodyDef()
      // To be able to determine object in collision
      ..setUserData(this)
      ..position = position
      ..type = BodyType.DYNAMIC;

    body = game.world.createBody(bodyDef)
      ..createFixtureFromFixtureDef(fixtureDef);
  }

  void render(Canvas c) {
    // prepareCanvas(c);
    c.save();
    c.translate(body.position.x, body.position.y);
    c.rotate(angle);
    var pos = Position(body.position.x, body.position.y);
    pos = Position(0, 0);
    ani?.getSprite()?.renderCentered(c, pos, size: Position(SIZE, SIZE));

    // var rect = Rect.fromLTWH(body.position.x, body.position.y, SIZE, SIZE);
    // print(rect);
    // ani.getSprite().renderRect(c, rect);
    // var v = body.linearVelocity;
    c.restore();
  }

  void reset() {
    var pos = Vector2(game.size.width / 2, game.size.height / 2);
    body.setTransform(pos, 0);

    angle = 0;
  }

  @override
  void update(double t) {
    ani?.update(t);
    angle = body.linearVelocity.g / 50;
    print(angle);
    // angle += t * SPEED;

    // if (angle > 3) {
    //   angle = 0;
    // }

    if (body.position.y >= game.size.height) {
      reset();
    }
  }

  void jump() {
    // angle -= SPEED;

    MassData data = MassData();
    body.getMassData(data);

    var impulse = Vector2(
      data.mass * 0,
      data.mass * -900,
    );

    body.applyLinearImpulse(impulse, body.position, true);
  }
}
