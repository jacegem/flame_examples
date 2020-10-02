import 'package:boxgame/box_game.dart';
import 'package:flame/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'brick/game/brick_game.dart';
import 'brick/game/game_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  Size size = await flameUtil.initialDimensions();
  BrickGame game = BrickGame(size);
  // runApp(game.widget);
  runApp(
    Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          game.widget,
          GameController(game),
        ],
      ),
    ),
  );
}
