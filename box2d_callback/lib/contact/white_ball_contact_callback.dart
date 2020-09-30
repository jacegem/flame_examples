import 'package:flame/box2d/contact_callbacks.dart';
import 'package:box2d_flame/box2d.dart';
import '../component/ball.dart';
import '../component/white_ball.dart';

class WhiteBallContactCallback extends ContactCallback<Ball, WhiteBall> {
  @override
  void begin(Ball ball, WhiteBall whiteBall, Contact contact) {
    ball.giveNudge = true;
  }

  @override
  void end(Ball ball, WhiteBall whiteBall, Contact contact) {}
}
