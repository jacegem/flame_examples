import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/gestures/tap.dart';
import 'package:save_red_square_flame/controllers/StaticText.dart';
import 'package:save_red_square_flame/controllers/TextedButton.dart';
import 'package:save_red_square_flame/data/DataHolder.dart';

import '../save_red_square.dart';
import 'BaseScreen.dart';
import 'ScreenState.dart';

class ScoreScreen extends BaseScreen {
  TextedButton _replay;
  StaticText _curScore;
  StaticText _bestScore;

  Size size = Size(0, 0);

  ScoreScreen() {
    _replay = TextedButton('RESTART', 0.5, 0.5);
    _curScore = StaticText(
        'SCORE: ' + dataHolder.getCurScore().toString(), 0.5, 0.2, 0.1);
    _bestScore = StaticText(
        'BEST: ' + dataHolder.getBestScore().toString(), 0.5, 0.3, 0.1);
  }

  @override
  void onTapDown(TapDownDetails details) {
    _replay.onTapDown(details, () {
      saveRedSquare.switchScreen(ScreenState.PlayGroundScreen);
    });
  }

  @override
  void render(Canvas canvas) {
    _replay.render(canvas);
    _curScore.render(canvas);
    _bestScore.render(canvas);
  }

  @override
  void resize(Size size) {
    this.size = size;

    _replay.resize(size);
    _curScore.resize(size);
    _bestScore.resize(size);
  }

  @override
  void update() {}
}
