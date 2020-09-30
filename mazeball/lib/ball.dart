import 'dart:ui';

import 'package:flame/box2d/box2d_component.dart';

class Ball extends BodyComponent {
  Paint paint;
//Size of the screen from the resize event
  Size screenSize;
//Rectangle based on the size, easy to use
  Rect _screenRect;
  final int scale = 5;

  Ball(Box2DComponent box) : super(box);

  void resize(Size size) {
    paint = Paint();
    paint.color = Color(0xffffffff);
    //Store size and related rectangle
    screenSize = size;
    _screenRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    super.resize(size);
  }

  void render(Canvas canvas) {
    //If no size information -> leave
    if (screenSize == null) {
      return;
    }
    //Save the canvas and resize/scale it based on the screenSize
    canvas.save();
    canvas.scale(screenSize.width / scale);
    //Move the canvas 0,0 to the position of the circle we draw
    canvas.translate(_screenRect.width / 2, _screenRect.height / 2);
    //Simply draw the circle with a radius of 0.1 using our paint
    canvas.drawCircle(Offset(0, 0), .1, paint);
    canvas.restore();
  }
}
