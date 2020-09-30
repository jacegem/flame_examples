import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/palette.dart';
import 'package:box2d_flame/box2d.dart';
import 'ball.dart';

class WhiteBall extends Ball {
  WhiteBall(Vector2 position, Box2DComponent box) : super(position, box) {
    originalPaint = BasicPalette.white.paint;
    currentPaint = originalPaint;
  }
}
