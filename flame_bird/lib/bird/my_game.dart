import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame/gestures.dart';

import 'bg.dart';
import 'bird.dart';

class MyGame extends BaseGame with TapDetector {
  Bird bird;
  Bg background;

  MyGame(Size size) {
    add(background = Bg());
    add(bird = Bird(size));
  }

  @override
  void onTap() {
    bird?.tap();
  }
}
