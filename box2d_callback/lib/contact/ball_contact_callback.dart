import 'package:box2d_callback/component/white_ball.dart';
import 'package:flame/box2d/contact_callbacks.dart';
import 'package:box2d_flame/box2d.dart';
import '../component/ball.dart';

class BallContactCallback extends ContactCallback<Ball, Ball> {
  @override
  void begin(Ball ball1, Ball ball2, Contact contact) {
    if (ball1 is WhiteBall || ball2 is WhiteBall) {
      return;
    }
    if (ball1.currentPaint != ball1.originalPaint) {
      ball1.currentPaint = ball2.currentPaint;
    } else {
      ball2.currentPaint = ball1.currentPaint;
    }
  }

  @override
  void end(Ball ball1, Ball ball2, Contact contact) {
    ball1.lifeDown();
  }
}
