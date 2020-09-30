import 'dart:ui';

import 'package:flame/game.dart';

import 'components/background.dart';

enum GameState {
  playing,
  gameOver,
}

class FluttersGame extends Game {
  Background skyBackground;
  double tileSize;
  Size viewport;

  FluttersGame(screenDimensions) {
    // skyBackground = Background(this, 0, 0, viewport.width, viewport.height);
    skyBackground = Background(this, 0, 0, 200, 200);
  }

  void resize(Size size) {
    viewport = size;
    tileSize = viewport.width / 6;
    // birdPosY = viewport.height - floorHeight - tileSize + (tileSize / 8);
  }

  @override
  void render(Canvas c) {
    skyBackground.render(c);
  }

  @override
  void update(double t) {
    skyBackground.update(t);
  }
}
