import 'package:box2d_simple/trex/trex_game_wrapper.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

import 'ball/my_game.dart';
import 'brick/brick_game.dart';
import 'brick2/brick2_game.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Flame.util.fullScreen();

//   // final MyBox2D box = MyBox2D();
//   // final MyGame game = MyGame(box);
//   // runApp(game.widget);

//   runApp(Brick2Game().widget);
// }

void main() {
  runApp(MaterialApp(
    title: 'TRexGame',
    color: Colors.white,
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: TRexGameWrapper(),
    ),
  ));

  Flame.util.fullScreen();
}

class MyBox2D extends Box2DComponent {
  MyBox2D() : super(scale: 4.0, gravity: -10.0);

  @override
  void initializeWorld() {}
}
