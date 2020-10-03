import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/flame.dart';
import 'package:flame_bird/world/world_game.dart';
import 'package:flutter/material.dart';

import 'bird/my_game.dart';
import 'box/box_game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final size = await Flame.util.initialDimensions();

  // final game = MyGame(size);
  // runApp(game.widget);

  // final MyBox2D box = MyBox2D();
  // final BoxGame game = BoxGame(size);
  // runApp(game.widget);

  Flame.images.loadAll(<String>[
    'bird-0.png',
    'bird-1.png',
    'bird-0-left.png',
    'bird-1-left.png',
    'cloud-1.png',
    'cloud-2.png',
    'cloud-3.png',
  ]);

  final MyBox2D box = MyBox2D();
  final WorldGame game = WorldGame(size);
  runApp(game.widget);
}

class MyBox2D extends Box2DComponent {
  MyBox2D() : super(scale: 10, gravity: -10.0);

  @override
  void initializeWorld() {}
}
