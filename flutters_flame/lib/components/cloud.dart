import 'package:flutters_flame/flutters_game.dart';

import 'core/game_object.dart';

class Cloud extends GameObject {
  double x;
  double y;

  Cloud(FluttersGame game, this.x, this.y) : super(game);
}
