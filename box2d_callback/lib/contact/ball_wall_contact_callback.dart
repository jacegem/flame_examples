import 'package:flame/box2d/contact_callbacks.dart';
import 'package:box2d_flame/box2d.dart';
import '../component/ball.dart';
import '../component/wall.dart';

class BallWallContactCallback extends ContactCallback<Ball, Wall> {
  @override
  void begin(Ball ball, Wall wall, Contact contact) {
    wall.paint = ball.currentPaint;
  }

  @override
  void end(Ball ball1, Wall wall, Contact contact) {}
}
