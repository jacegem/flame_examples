import 'dart:async';

import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:save_red_square_flame/controllers/StaticText.dart';
import 'package:save_red_square_flame/data/DataHolder.dart';

import '../save_red_square.dart';
import 'BaseScreen.dart';
import 'ScreenState.dart';

class LoadingScreen extends BaseScreen {
  StaticText _loadingText;
  double _progress = 0;

  static const white = PaletteEntry(Colors.white);

  Size size = Size(0, 0);

  LoadingScreen() {
    _loadingText = StaticText("LOADING", 0.5, 0.4, 0.1);

    Timer.periodic(Duration(milliseconds: 10), (timer) {
      _progress += 1;
      if (_progress >= 100) {
        timer.cancel();
        if (dataHolder.getUserName() == "") {
          saveRedSquare.switchScreen(ScreenState.SetUserScreen);
        } else {
          saveRedSquare.switchScreen(ScreenState.MenuScreen);
        }
      }
    });
  }
  @override
  void onTapDown(TapDownDetails details) {}

  @override
  void render(Canvas canvas) {
    _loadingText.render(canvas);

    canvas.drawRect(
        Rect.fromLTWH(size.width * 0.1, size.height * 0.5,
            size.width * 0.8 * (_progress / 100), size.height * 0.05),
        white.paint);
  }

  @override
  void resize(Size size) {
    this.size = size;
    _loadingText.resize(size);
  }

  @override
  void update() {
    _loadingText.update();
  }
}
