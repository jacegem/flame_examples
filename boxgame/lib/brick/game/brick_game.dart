import 'dart:ui';

import 'package:boxgame/brick/component/brick.dart';
import 'package:boxgame/brick/component/goal.dart';
import 'package:flame/game/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/gestures.dart';
import 'package:box2d_flame/box2d.dart';

import '../component/ball.dart';
import '../component/wall.dart';

class BrickGame extends Game with TapDetector implements ContactListener {
  Size screenSize;
  int width_scale = 10;
  int height_scale;
  double unit;
  World world;

  // List<Brick> bricks;
  // List<Ball> balls;
  List<Wall> walls = [];
  Wall topWall;
  Wall bottomWall;
  Ball ball;
  Goal goal;
  List<Brick> bricks = [];
  // VerticalWall leftWall;
  // VerticalWall rightWall;

  BrickGame(this.screenSize) {
    world = World.withPool(
      Vector2(0, 0),
      DefaultWorldPool(100, 10),
    );
    world.setContactListener(this);

    // if 9 bricks => make 10 block for  2 wall
    width_scale = 10;
    height_scale = (width_scale * 1.5).toInt();

    walls.add(Wall(this, WallType.top));
    walls.add(Wall(this, WallType.bottom));
    walls.add(Wall(this, WallType.left));
    walls.add(Wall(this, WallType.right));

    ball = Ball(this);
    goal = Goal(this);

    for (int i = 0; i < 10; i++) {
      bricks.add(Brick(this));
    }
  }

  // void resize(Size size) {
  //   screenSize = size;
  //   super.resize(size);
  // }

  @override
  void render(Canvas c) {
    if (screenSize == null) {
      return;
    }

    c.save();
    c.scale(screenSize.width / width_scale);
    // bricks.forEach((Brick b) => b.render(c));
    // balls.forEach((Ball b) => b.render(c));
    walls.forEach((Wall w) => w.render(c));
    ball.render(c);
    goal.render(c);
    bricks.forEach((Brick b) => b.render(c));

    c.restore();
  }

  @override
  void update(double t) {
    if (screenSize == null) {
      return;
    }

    world.stepDt(t, 100, 100);
    ball?.update(t);
  }

  void onRightDragStart(DragDownDetails d) {
    ball.moveRight();
  }

  void onLeftDragStart(DragDownDetails d) {
    ball.moveLeft();
  }

  void onStart() {
    ball.start();
  }

  void onRotateLeft() {
    ball.rotateLeft();
  }

  void onRotateRight() {
    ball.rotateRight();
  }

  @override
  void beginContact(Contact contact) {
    if (contact.fixtureA.userData == 'goal') {
      (contact.fixtureA.getBody().userData as Goal).touch();
    }

    if (contact.fixtureB.userData == 'goal') {
      (contact.fixtureB.getBody().userData as Goal).touch();
    }
  }

  @override
  void endContact(Contact contact) {
    // TODO: implement endContact
  }

  @override
  void postSolve(Contact contact, ContactImpulse impulse) {
    // TODO: implement postSolve
  }

  @override
  void preSolve(Contact contact, Manifold oldManifold) {
    // TODO: implement preSolve
  }
}
