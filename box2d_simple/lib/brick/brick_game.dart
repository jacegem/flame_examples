import 'dart:ui';

import 'package:box2d_flame/box2d.dart' hide Timer;
import 'package:box2d_simple/brick/vertical_wall.dart';
import 'package:flame/components/parallax_component.dart';

import 'package:flame/game.dart';
import 'package:flutter/painting.dart';

import 'ball.dart';
import 'brick.dart';
import 'horizontal_wall.dart';

class BrickGame extends Game implements ContactListener, ContactFilter {
  World world;
  Size screenSize;
  Size tileGrid;
  TextStyle textStyle = TextStyle(fontSize: .25);

  List<Brick> bricks;
  List<Ball> balls;
  HorizontalWall topWall;
  HorizontalWall bottomWall;
  VerticalWall leftWall;
  VerticalWall rightWall;

  double spawnOnZero = 0;

  BrickGame() {
    world = World.withPool(
      Vector2(0, 0),
      DefaultWorldPool(100, 10),
    );
    world.setContactListener(this);
    world.setContactFilter(this);
  }

  @override
  void render(Canvas c) {
    if (screenSize == null) {
      return;
    }

    c.save();
    c.translate(screenSize.width / 2, screenSize.height / 2);
    c.scale(screenSize.width / 9);

    bricks.forEach((Brick b) => b.render(c));
    balls.forEach((Ball b) => b.render(c));
    topWall.render(c);
    bottomWall.render(c);
    leftWall.render(c);
    rightWall.render(c);

    c.restore();
  }

  @override
  void update(double t) {
    if (screenSize == null) {
      return;
    }

    world.stepDt(t, 100, 100);

    bricks.forEach((Brick b) => b.update(t));
    balls.forEach((Ball b) => b.update(t));
    topWall.update(t);
    bottomWall.update(t);
    leftWall.update(t);
    rightWall.update(t);

    spawnOnZero -= t;
    if (spawnOnZero <= 0 && balls.length < 5) {
      balls.add(Ball(this, Vector2(0, 0)));
      spawnOnZero = .0375;
    }

    bricks
        .where((Brick b) => b.isForDestruction)
        .forEach((Brick b) => b.destroy());
    bricks.removeWhere((Brick b) => b.isForRemoval);
  }

  @override
  void resize(Size size) {
    screenSize = size;
    tileGrid = Size(9, size.height / (size.width / 9));

    // bricks
    if (bricks == null) {
      bricks = List<Brick>();
      for (double y = -7.5; y <= -.5; y += .5) {
        for (double x = -4; x <= 4; x += .5) {
          bricks.add(
            Brick(
              this,
              Vector2(x, y),
              hp: 75 - y.toInt(),
            ),
          );
        }
      }
    }

    // balls
    if (balls == null) {
      balls = List<Ball>();
    }

    // walls
    if (topWall == null) {
      topWall = HorizontalWall(this, Vector2(0, -7.875), 8.75);
    }
    if (bottomWall == null) {
      bottomWall = HorizontalWall(this, Vector2(0, 7.875), 8.75);
    }
    if (leftWall == null) {
      leftWall = VerticalWall(this, Vector2(-4.375, 0), 15.75);
    }
    if (rightWall == null) {
      rightWall = VerticalWall(this, Vector2(4.375, 0), 15.75);
    }
  }

  @override
  void beginContact(Contact contact) {
    if (contact.fixtureA.userData == 'brick') {
      (contact.fixtureA.getBody().userData as Brick).impact();
    }
    if (contact.fixtureB.userData == 'brick') {
      (contact.fixtureB.getBody().userData as Brick).impact();
    }
  }

  @override
  void endContact(Contact contact) {}

  @override
  void postSolve(Contact contact, ContactImpulse impulse) {}

  @override
  void preSolve(Contact contact, Manifold oldManifold) {}

  @override
  bool shouldCollide(Fixture fixtureA, Fixture fixtureB) {
    // if (fixtureA.userData == 'ball' && fixtureB.userData == 'ball') {
    //   return false;
    // }
    return true;
  }
}
