import 'dart:ui';
import 'dart:math' as math;
import 'package:flame/anchor.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:box2d_flame/box2d.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class Bird extends AnimationComponent with Resizable {
  static const SIZE = 52.0;
  static const GRAVITY = 400.0;
  static const BOOST = -380.0;

  bool frozen = true;
  double speedY;

  var game;

  Bird(this.game)
      : super.sequenced(
          SIZE,
          SIZE,
          'bird.png',
          4,
          textureWidth: 16.0,
          textureHeight: 16.0,
        ) {
    anchor = Anchor.bottomCenter;
    x = game.size.width / 2;
    y = game.size.height / 2;
  }

  // Position get velocity => Position(200.0, speedY);

  // void reset() {
  //   frozen = true;
  //   x = size.width / 2;
  //   y = size.height / 2;
  //   speedY = 0.0;
  //   angle = velocity.angle();
  // }
  @override
  void resize(Size size) {
    super.resize(size);
    // this.reset();
  }

  // @override
  // void update(double t) {
  //   if (!frozen) {
  //     super.update(t);
  //     this.y += speedY * t - GRAVITY * t * t / 2;
  //     this.speedY += GRAVITY * t;
  //     this.angle = velocity.angle();

  //     if (y > size.height + 150) {
  //       this.reset();
  //     }
  //   }
  // }

  void boost() {
    speedY = (speedY + BOOST).clamp(BOOST, speedY);
  }

  void tap() {
    if (frozen) {
      frozen = false;
    } else {
      boost();
    }
  }
}
