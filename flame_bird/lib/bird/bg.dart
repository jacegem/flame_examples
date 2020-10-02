import 'dart:ui';

import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/components/component.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class Bg extends Component with Resizable {
  // static const color = PaletteEntry(Colors.brown);
  static final _brown = const Color(0xFFDDC0A3);
  Color color = Bg._brown;

  @override
  void render(Canvas c) {
    // Paint paint = Paint();
    // paint.color = Color(0xffaabbcc);

    var rect = Rect.fromLTWH(0, 0, size.width, size.height);
    c.drawRect(rect, bgColor);
  }

  get bgColor => Paint()..color = color;

  @override
  void update(double t) {}
}
