import 'dart:math';
import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/position.dart';
import 'package:flame/spritesheet.dart';
import 'package:flutter/material.dart';
import 'package:trex/bob/bob_game.dart';

import 'asset.dart';

const double ORIGINAL_SIZE = 50;

class Player extends PositionComponent {
  static const PLAYER_SPEED = 200;
  int _playerDirection = 1;

  BobGame game;
  SpriteSheet _spriteSheet;

  // ignore: sort_constructors_first
  Player(this.game) {
    setByPosition(Position(game.size.width / 2 - 25, game.size.height - 200));
    width = ORIGINAL_SIZE;
    height = ORIGINAL_SIZE;

    _spriteSheet = SpriteSheet.fromImage(
      image: Asset.bob,
      textureWidth: 16,
      textureHeight: 16,
      columns: 6,
      rows: 1,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    x += PLAYER_SPEED * dt * _playerDirection;

    final rect = toRect();
    if (rect.left <= 0) {
      _playerDirection = 1;
      setByPosition(Position(0, rect.top));
    }

    if (rect.right >= game.size.width) {
      setByPosition(Position(game.size.width - rect.width, rect.top));
      _playerDirection = -1;
    }
  }

  @override
  void render(Canvas c) {
    final rect = toRect();
    final _sprite = _spriteSheet.getSprite(0, 1);

    // final curve =
    //     Curves.easeIn.transformInternal(_holdingTimer.current / HOLDING_LIMIT);

    final _paint = Paint()
      ..colorFilter = ColorFilter.mode(
          const Color(0xFFd42255).withOpacity(0.8), BlendMode.srcATop);
    _sprite.renderRect(c, rect, overridePaint: _paint);
  }
}
