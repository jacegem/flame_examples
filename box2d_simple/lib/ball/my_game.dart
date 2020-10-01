import 'dart:ui';
import 'dart:math' as math;
import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/box2d/box2d_game.dart';
import 'package:flame/components/parallax_component.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/gestures.dart';
import 'package:flame/box2d/box2d_game.dart';
import 'ball.dart';
import '../ball/my_planet.dart';
import 'package:box2d_flame/box2d.dart';

class MyGame extends Box2DGame with TapDetector {
  MyGame(Box2DComponent box) : super(box) {
    final images = [
      ParallaxImage('bg.png'),
      // ParallaxImage('mountain-far.png'),
      // ParallaxImage('mountains.png'),
      // ParallaxImage('trees.png'),
      // ParallaxImage('foreground-trees.png'),
    ];

    final parallaxComponent = ParallaxComponent(
      images,
      baseSpeed: Offset(20, 0),
      layerDelta: Offset(30, 0),
    );

    // add(parallaxComponent);
    // add(MyPlanet(box));
  }

  @override
  void onTapDown(TapDownDetails details) {
    super.onTapDown(details);
    final Vector2 position =
        Vector2(details.globalPosition.dx, details.globalPosition.dy);

    add(Ball(position, box));
  }
}
