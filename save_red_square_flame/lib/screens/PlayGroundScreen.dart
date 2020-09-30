import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/gestures/tap.dart';
import 'package:save_red_square_flame/controllers/RedSquare.dart';
import 'package:save_red_square_flame/controllers/ScoreHolder.dart';
import 'package:save_red_square_flame/data/DataHolder.dart';

import '../save_red_square.dart';
import 'BaseScreen.dart';
import 'ScreenState.dart';

class PlayGroundScreen extends BaseScreen {
  RedSquare _redSquare;
  ScoreHolder _scoreHolder;

  bool _isGameOver = false;

  PlayGroundScreen() {
    _redSquare = RedSquare();
    _scoreHolder = ScoreHolder(0.5, 0.1);
  }
  @override
  void onTapDown(TapDownDetails details) {
    _redSquare.onTapDown(details, () {});
  }

  @override
  void render(Canvas canvas) {
    _redSquare.render(canvas);
    _scoreHolder.render(canvas);
  }

  @override
  void resize(Size size) {
    _redSquare.resize(size);
    _scoreHolder.resize(size);
  }

  @override
  void update() {
    if (!_isGameOver) {
      _redSquare.update();
      _scoreHolder.update();

      if (_redSquare.isGameOver()) {
        _isGameOver = true;
        dataHolder.setNewScore(_scoreHolder.getScore());
        saveRedSquare.switchScreen(ScreenState.ScoreScreen);
      }
    }
  }
}
