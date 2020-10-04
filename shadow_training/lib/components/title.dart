import 'dart:ui';

import 'package:flame/sprite.dart';

import '../shadow_training.dart';

class Title {
  final ShadowTraining game;
  Sprite sprite;
  Rect rect;

  Title(this.game) {
    sprite = Sprite('title.png');
    rect = Rect.fromLTWH(1, game.screenHeight * -.775, 7, 3);
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }
}
