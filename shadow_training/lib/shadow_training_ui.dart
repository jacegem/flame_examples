import 'package:flutter/material.dart';
import 'package:shadow_training/shadow_training.dart';
import 'package:shadow_training/widgets/punch_buttons.dart';

import 'bgm.dart';

enum UIScreen { home, playing, lost, help, credits }

class ShadowTrainingUI extends StatefulWidget {
  final ShadowTrainingUIState state = ShadowTrainingUIState();

  @override
  ShadowTrainingUIState createState() => state;
}

class ShadowTrainingUIState extends State<ShadowTrainingUI> {
  ShadowTraining game;

  UIScreen currentScreen = UIScreen.home;
  bool isBGMEnabled = true;
  bool isSFXEnabled = true;
  int score = 0;
  int highScore = 0;

  Widget bgmControlButton() {
    return Ink(
      decoration: ShapeDecoration(
        shape: CircleBorder(),
      ),
      child: IconButton(
        color: isBGMEnabled ? Colors.white : Colors.grey,
        icon: Icon(
          isBGMEnabled ? Icons.music_note : Icons.music_video,
        ),
        onPressed: () {
          isBGMEnabled = !isBGMEnabled;
          if (isBGMEnabled) {
            BGM.resume();
          } else {
            BGM.pause();
          }
          update();
        },
      ),
    );
  }

  void update() {
    setState(() {});
  }

  Widget topControls() {
    return Padding(
      padding: EdgeInsets.only(top: 5, left: 5, right: 15),
      child: Row(
        children: <Widget>[
          bgmControlButton(),
          // sfxControlButton(),
          // helpButton(),
          // creditsButton(),
          // spacer(),
          // highScoreDisplay(),
        ],
      ),
    );
  }

  Widget buildScreenHome() {
    return Positioned.fill(
      child: Column(
        children: <Widget>[
          spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: Center(
              child: RaisedButton(
                color: Color(0xff032626),
                child: Text(
                  'Start Training!',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 35,
                  vertical: 20,
                ),
                onPressed: () {
                  currentScreen = UIScreen.playing;
                  game.start();
                  update();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget spacer({int size}) {
    return Expanded(
      flex: size ?? 100,
      child: Center(),
    );
  }

  Widget scoreDisplay() {
    return Text(
      score.toString(),
      style: TextStyle(
        fontSize: 150,
        color: Colors.green,
        shadows: <Shadow>[
          Shadow(
            color: Color(0x88000000),
            blurRadius: 10,
            offset: Offset(2, 2),
          ),
        ],
      ),
    );
  }

  Widget buildScreenPlaying() {
    return Positioned.fill(
      child: Column(
        children: <Widget>[
          spacer(size: 45),
          scoreDisplay(),
          spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: Row(
              children: <Widget>[
                spacer(),
                GestureDetector(
                  onTapDown: (TapDownDetails d) => game.boxer.punchLeft(),
                  behavior: HitTestBehavior.opaque,
                  child: LeftPunch(),
                ),
                spacer(),
                GestureDetector(
                  onTapDown: (TapDownDetails d) => game.boxer.upperCut(),
                  behavior: HitTestBehavior.opaque,
                  child: Uppercut(),
                ),
                spacer(),
                GestureDetector(
                  onTapDown: (TapDownDetails d) => game.boxer.punchRight(),
                  behavior: HitTestBehavior.opaque,
                  child: RightPunch(),
                ),
                spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        topControls(),
        Expanded(
          child: IndexedStack(
            sizing: StackFit.expand,
            children: <Widget>[
              buildScreenHome(),
              buildScreenPlaying(),
              // buildScreenLost(),
              // buildScreenHelp(),
              // buildScreenCredits(),
            ],
            index: currentScreen.index,
          ),
        ),
      ],
    );
  }
}
