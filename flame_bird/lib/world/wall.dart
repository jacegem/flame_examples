import 'dart:ui';

import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/sprite.dart';

class Wall {
  // static const color = PaletteEntry(Colors.brown);
  static final _brown = const Color(0xFFDDC0A3);
  Color color = Wall._brown;
  Size size;
  Wall(this.size);

  void render(Canvas c) {
    // Paint paint = Paint();
    // paint.color = Color(0xffaabbcc);
    c.save();
    // var rect = Rect.fromLTWH(0, 0, size.width, size.height);
    // var rect = Rect.fromLTWH(100, 100, 100, 100);
    // c.drawRect(rect, bgColor);

    Sprite player = Sprite('bird-0.png');
    player.render(c); //canvas, width, height
    c.restore();
  }

  get bgColor => Paint()..color = color;

  void update(double t) {}
}
