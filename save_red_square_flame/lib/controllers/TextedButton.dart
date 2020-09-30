import 'package:flutter/material.dart';
import 'package:flutter/src/gestures/tap.dart';

import 'dart:ui';

import 'BaseWidget.dart';

class TextedButton extends BaseWidget {
  final double _xRatio;
  final double _yRatio;
  final String _text;

  TextPainter _painter;
  TextStyle _textStyle;

  Offset _position;

  TextedButton(this._text, this._xRatio, this._yRatio) {
    _painter = TextPainter(
        textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    _textStyle = TextStyle(
      color: Colors.white,
      fontSize: 0,
    );

    _painter.text = TextSpan(text: _text, style: _textStyle);
    _painter.layout();
    _position = Offset(0, 0);
  }

  @override
  void render(Canvas canvas) {
    _painter.paint(canvas, _position);
  }

  @override
  void onTapDown(TapDownDetails details, Function fn) {
    var pos = details.globalPosition;
    if (pos.dx >= _position.dx && pos.dx <= _position.dx + _painter.width) {
      if (pos.dy >= _position.dy && pos.dy <= _position.dy + _painter.height) {
        fn();
      }
    }
  }

  @override
  void resize(Size size) {
    _textStyle = TextStyle(
      color: Colors.white,
      fontSize: size.width * 0.1,
    );

    _painter.text = TextSpan(text: _text, style: _textStyle);
    _painter.layout();

    _position = Offset(
      size.width * _xRatio - (_painter.width * 0.5),
      size.height * _yRatio - (_painter.height * 0.5),
    );
  }

  @override
  void update() {}
}
