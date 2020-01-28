import 'dart:ui';

import 'package:newprojectx/box-game.dart';

class Target {

  final BoxGame game;  
  Rect targetRect;
  Paint targetPaint;

  Target(this.game, double x, double y) {
    targetRect = Rect.fromLTWH(x, y, 2*game.tileSize, 2*game.tileSize);
    targetPaint = Paint();
    targetPaint.color = Color(0xff00f000);
  }

  void render(Canvas c) {
    c.drawRect(targetRect, targetPaint);
    game.player.render(c);
  }

  void update(double t) {}

}