import 'dart:async';
import 'dart:ui';

import 'package:flame/game/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:save_red_square_flame/screens/BaseScreen.dart';
import 'package:save_red_square_flame/screens/BlankScreen.dart';
import 'package:save_red_square_flame/screens/LoadingScreen.dart';
import 'package:save_red_square_flame/screens/MenuScreen.dart';
import 'package:save_red_square_flame/screens/PlayGroundScreen.dart';
import 'package:save_red_square_flame/screens/ScreenState.dart';

import 'data/DataHolder.dart';
import 'screens/ScoreScreen.dart';

SaveRedSquare saveRedSquare = SaveRedSquare();

class SaveRedSquare extends Game with TapDetector {
  ScreenState _screenState;
  BaseScreen _menuScreen;
  BaseScreen _playGroundScreen;
  BaseScreen _scoreScreen;
  BaseScreen _loadingScreen;
  BaseScreen _blankScreen;

  Function _fnUpdate;
  Function _callBack;
  Size _size = Size(0, 0);

  SaveRedSquare() {
    _screenState = ScreenState.LoadingScreen;

    _menuScreen = MenuScreen();
    _playGroundScreen = PlayGroundScreen();
    _scoreScreen = ScoreScreen();
    _loadingScreen = LoadingScreen();

    _blankScreen = BlankScreen();

    _fnUpdate = _init;
    _callBack = _doNothing;
  }

  Future<void> _init() async {
    _fnUpdate = _update;

    Util flameUtil = Util();
    await flameUtil.fullScreen();
    await flameUtil.setOrientation(DeviceOrientation.portraitDown);
    dataHolder.loadData();
  }

  @override
  void resize(Size size) {
    _menuScreen?.resize(size);
    _playGroundScreen?.resize(size);
    _scoreScreen?.resize(size);
    _loadingScreen?.resize(size);
    _blankScreen?.resize(size);

    _size = size;
  }

  @override
  void render(Canvas c) {
    _getActiveScreen()?.render(c);
  }

  void _doNothing() {}

  @override
  void update(double t) {
    _fnUpdate();
  }

  void _update() {
    _getActiveScreen()?.update();
  }

  BaseScreen _getActiveScreen() {
    switch (_screenState) {
      case ScreenState.LoadingScreen:
        return _loadingScreen;
      case ScreenState.MenuScreen:
        return _menuScreen;
      case ScreenState.PlayGroundScreen:
        return _playGroundScreen;
      case ScreenState.ScoreScreen:
        return _scoreScreen;
      default:
        return _blankScreen;
    }
  }

  void onTapDown(TapDownDetails details) {
    _getActiveScreen()?.onTapDown(details);
  }

  void setCallBack(Function fn) {
    _callBack = fn;
  }

  ScreenState getState() {
    return _screenState;
  }

  void _setState(ScreenState newState) {
    print('newState : $newState');

    this._screenState = newState;
    _callBack();
  }

  void switchScreen(ScreenState newScreen) {
    switch (newScreen) {
      case ScreenState.LoadingScreen:
        _setState(newScreen);
        break;
      case ScreenState.ScoreScreen:
        _scoreScreen = ScoreScreen();
        Timer(new Duration(seconds: 3), () {
          _scoreScreen.resize(_size);
          _setState(newScreen);
        });
        break;
      case ScreenState.PlayGroundScreen:
        _playGroundScreen = PlayGroundScreen();
        _playGroundScreen.resize(_size);
        Timer(new Duration(milliseconds: 10), () {
          _setState(newScreen);
        });
        break;
      case ScreenState.MenuScreen:
        _setState(newScreen);
        _menuScreen = MenuScreen();
        _menuScreen.resize(_size);
        Timer(new Duration(milliseconds: 10), () {
          _setState(newScreen);
        });
        break;
      default:
        _setState(newScreen);
    }
  }
}
