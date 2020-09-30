import 'package:box2d_callback/my_game.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.util.fullScreen();
  final MyBox2D box = MyBox2D();
  final MyGame game = MyGame(box);
  runApp(game.widget);
}

class MyBox2D extends Box2DComponent {
  MyBox2D() : super(scale: 4.0, gravity: -10.0);

  @override
  void initializeWorld() {}
}
