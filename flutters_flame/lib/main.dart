import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'flutters_game.dart';

// void main() {
//   runApp(MyApp());
// }

void main() async {
  Util flameUtil = Util();
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await Flame.util.setPortrait();
    await Flame.util.fullScreen();
  }

  Flame.images.loadAll(<String>[
    'bird-0.png',
    'bird-1.png',
    'bird-0-left.png',
    'bird-1-left.png',
    'cloud-1.png',
    'cloud-2.png',
    'cloud-3.png',
  ]);

  final screenDimensions = await Flame.util.initialDimensions();
  FluttersGame game = FluttersGame(screenDimensions);

  runApp(game.widget);
}
