import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:save_red_square_flame/controllers/StaticText.dart';
import 'package:save_red_square_flame/controllers/TextedButton.dart';
import 'package:save_red_square_flame/data/DataHolder.dart';

import '../save_red_square.dart';
import 'BaseScreen.dart';
import 'ScreenState.dart';

class MenuScreen extends BaseScreen {
  TextedButton _startButton;
  StaticText _staticText;

  MenuScreen() {
    _startButton = TextedButton("START", 0.5, 0.5);
    _staticText =
        StaticText("Greetings, " + dataHolder.getUserName(), 0.5, 0.3, 0.07);
  }
  @override
  void onTapDown(TapDownDetails details) {
    print(
        "Player tap down on ${details.globalPosition.dx} - ${details.globalPosition.dy}");

    _startButton.onTapDown(details, () {
      saveRedSquare.switchScreen(ScreenState.PlayGroundScreen);
    });
  }

  @override
  void render(Canvas canvas) {
    _startButton.render(canvas);
    _staticText.render(canvas);
  }

  @override
  void resize(Size size) {
    _startButton.resize(size);
    _staticText.resize(size);
  }

  @override
  void update() {
    _startButton.update();
  }
}
