import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flame_bird/world/world_game.dart';

class Backyard {
  final WorldGame game;
  Sprite bgSprite;
  Rect bgRect;

  Backyard(this.game) {
    bgSprite = Sprite('backyard.png');
    bgRect = Rect.fromLTWH(
      0,
      0,
      game.size.width,
      game.size.height,
    );
  }

  void render(Canvas c) {
    c.save();
    bgSprite.renderRect(c, bgRect);
    c.restore();
  }

  void update(double t) {}
}
