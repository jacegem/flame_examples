import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'mazeball_game.dart';

void main() async {
  //Make sure flame is ready before we launch our game
  await setupFlame();
  final MyBox2D box = MyBox2D();
  var game = new MazeBallGame(box);
  runApp(game.widget);
}

/// Setup all Flame specific parts
Future setupFlame() async {
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);
}

class MyBox2D extends Box2DComponent {
  MyBox2D() : super(scale: 4.0, gravity: 0.0);

  @override
  void initializeWorld() {}
}
