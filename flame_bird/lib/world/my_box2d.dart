import 'package:flame/box2d/box2d_component.dart';

class MyBox2D extends Box2DComponent {
  MyBox2D() : super(scale: 4.0, gravity: -10.0);

  @override
  void initializeWorld() {}
}
