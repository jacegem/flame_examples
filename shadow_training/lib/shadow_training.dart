import 'dart:math';
import 'dart:ui';

import 'package:flame/game/game.dart';
import 'package:flutter/src/gestures/tap.dart';
import 'package:shadow_training/shadow_training_ui.dart';

import 'components/background.dart';

class ShadowTraining extends Game {
  final ShadowTrainingUIState ui;
  Random rnd;

  // components
  Background background;

  ShadowTraining(this.ui) {
    rnd = Random();

    // components
    background = Background(this);
  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render
  }

  @override
  void update(double t) {
    // TODO: implement update
  }

  void onTapDown(TapDownDetails details) {}
}
