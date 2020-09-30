import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:save_red_square_flame/flutter_screens/username_screen.dart';
import 'package:save_red_square_flame/screens/ScreenState.dart';

import '../save_red_square.dart';

FlutterScreenManager flutterScreenManager = FlutterScreenManager();

class FlutterScreenManager extends StatefulWidget {
  @override
  _FlutterScreenManagerState createState() => _FlutterScreenManagerState();
}

class _FlutterScreenManagerState extends State<FlutterScreenManager> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown]);

    saveRedSquare.setCallBack(this.refreshState);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            saveRedSquare.widget,
            getFlutterWidget(),
          ],
        ),
      ),
    );
  }

  Widget getFlutterWidget() {
    switch (saveRedSquare.getState()) {
      case ScreenState.SetUserScreen:
        return UserNameScreen();
      default:
        return Container();
    }
  }

  void refreshState() {
    setState(() {});
  }
}
