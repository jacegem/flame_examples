import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

import 'bird/my_game.dart';
import 'box/box_game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final size = await Flame.util.initialDimensions();

  // final game = MyGame(size);
  // runApp(game.widget);

  final MyBox2D box = MyBox2D();
  final BoxGame game = BoxGame(size);
  runApp(game.widget);
}

class MyBox2D extends Box2DComponent {
  MyBox2D() : super(scale: 10, gravity: -10.0);

  @override
  void initializeWorld() {}
}
