import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadow_training/shadow_training_ui.dart';

import 'bgm.dart';
import 'shadow_training.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.util.fullScreen();
  await Flame.util.setOrientation(DeviceOrientation.portraitUp);
  await Flame.images.loadAll(<String>[
    'background.png',
    'boxer/dizzy.png',
    'boxer/idle.png',
    'boxer/punch-left.png',
    'boxer/punch-right.png',
    'boxer/punch-up.png',
    'markers.png',
    'perfect-time.png',
    'title.png',
  ]);

  List<String> audioList = ['bgm.ogg'];
  for (int i = 1; i <= 13; i++) {
    audioList.add('swish-$i.ogg');
  }
  await Flame.audio.loadAll(audioList);
  // await SFX.preload();
  await BGM.preload();
  // BGM.play();

  final size = await Flame.util.initialDimensions();
  ShadowTrainingUI gameUI = ShadowTrainingUI();
  ShadowTraining game = ShadowTraining(gameUI.state, size);
  gameUI.state.game = game;

  runApp(
    MaterialApp(
      title: 'Shadow Training',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'HVD',
      ),
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapDown: game.onTapDown,
                child: game.widget,
              ),
            ),
            Positioned.fill(
              child: gameUI,
            ),
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
