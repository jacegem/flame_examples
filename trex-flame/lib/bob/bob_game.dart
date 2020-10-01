import 'dart:ui';

import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/game/base_game.dart';
import 'package:flame/game/game.dart';
import 'package:trex/bob/player.dart';

class BobGame extends BaseGame {
  Player player;

  // ignore: sort_constructors_first
  BobGame(Size size) {
    this.size = size;
    player = Player(this);
    add(player);
  }
}
