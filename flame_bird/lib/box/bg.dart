import 'dart:ui';

class Bg {
  var game;

  Bg(this.game);

  // static const color = PaletteEntry(Colors.brown);
  static final _brown = const Color(0xFFDDC0A3);
  Color color = Bg._brown;

  void render(Canvas c) {
    var rect = Rect.fromLTWH(0, 0, game.size.width, game.size.height);
    c.drawRect(rect, bgColor);
  }

  get bgColor => Paint()..color = color;
}
