import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/game.dart';
import 'package:flame/game/base_game.dart';
import 'package:flutter/rendering.dart';

import '../flutters_game.dart';
import 'cloud.dart';
import 'core/game_object.dart';

class Background extends GameObject {
  final Gradient gradient = new LinearGradient(
    begin: Alignment.topCenter,
    colors: <Color>[
      Color(0xff0165b1),
      Color(0xffFFFFFF),
    ],
    stops: [
      0.0,
      1.0,
    ],
    end: Alignment(0, 0.9),
  );
  Paint paint;
  Rect rect;

  Background(FluttersGame game, double x, double y, double width, double height)
      : super(game) {
    paint = Paint();
    paint.color = Color(0xff77b5e1);

    rect = Rect.fromLTWH(x, y, width, height);
    paint = new Paint()..shader = gradient.createShader(rect);
    this.addChild(Cloud(this.game, 0, game.tileSize * 1.7));
    this.addChild(Cloud(this.game, 0, game.tileSize * 4.4));
  }

  @override
  void render(Canvas c) {
    c.drawRect(rect, paint);
    super.render(c);
  }

  @override
  void update(double t) {
    super.update(t);
  }
}
