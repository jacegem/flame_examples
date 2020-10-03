import 'dart:ui';
import 'package:flame/position.dart';
import 'package:flame_bird/world/world_game.dart';
import 'package:flutter/material.dart';
import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/palette.dart';
import 'dart:math' as math;

class Square extends PositionComponent {
  static const SPEED = 0.25;

  final rotate;

  WorldGame game;

  Square(this.game, this.rotate) {
    width = 100;
    height = 100;
    anchor = Anchor.center;

    var pos = Position(200, 200);
    setByPosition(pos);
  }

  @override
  void render(Canvas c) {
    prepareCanvas(c);

    c.drawRect(
        Rect.fromLTWH(0, 0, width, height), PaletteEntry(Colors.white).paint);
    c.drawRect(Rect.fromLTWH(0, 0, 200, 200), PaletteEntry(Colors.red).paint);
    c.drawRect(Rect.fromLTWH(width / 2, height / 2, 30, 30),
        PaletteEntry(Colors.blue).paint);
  }

  @override
  void update(double t) {
    if (rotate != null) {
      angle += SPEED * t;
      angle %= 2 * math.pi;
    }
  }
}
