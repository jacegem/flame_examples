import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'game.dart';

//TODO Keep screen active -> no sleep

void main() async {
  //Make sure flame is ready before we launch our game
  WidgetsFlutterBinding
      .ensureInitialized(); //Since flutter upgrade this is required
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  Util flameUtil = Util();
  Size size = await flameUtil.initialDimensions();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  final MyBox2D box = MyBox2D();
  var game = new MazeBallGame(box, size);
  runApp(game.widget);
}

/// Setup all Flame specific parts
// Future setupFlame() async {
//   WidgetsFlutterBinding
//       .ensureInitialized(); //Since flutter upgrade this is required
//   sharedPrefs = await SharedPreferences.getInstance();
//   flameUtil = Util();
//   Size size = await flameUtil.initialDimensions();
//   await flameUtil.fullScreen();
//   await flameUtil.setOrientation(
//       DeviceOrientation.portraitUp); //Force the app to be in this screen mode
// }

class MyBox2D extends Box2DComponent {
  // MyBox2D() : super(scale: 4.0, gravity: -10.0);
  MyBox2D() : super(gravity: 0);

  @override
  void initializeWorld() {}
}
