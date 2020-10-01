import 'dart:ui' as ui;
import 'bob_game.dart';

class Asset {
  static BobGame game;

  // Caching these images so we can use this right away on our UI
  static ui.Image hatsWithBackground;
  static ui.Image hats;
  static ui.Image bob;
  static ui.Image enemies;

  // static SoundManager soundManager;
}
