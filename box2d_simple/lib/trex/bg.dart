import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';

class Bg extends Component with Resizable {
  Bg();

  final Paint _paint = Paint()..color = const Color(0xffffffff);

  @override
  void render(Canvas c) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    c.drawRect(rect, _paint);
  }

  @override
  void update(double t) {}
}
