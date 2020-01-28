import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:newprojectx/box-game.dart';

class Target {

  final BoxGame game;  
  Rect targetRect;
  Paint targetPaint;
  Sprite box =  Sprite('box.png');

  Target(this.game, double x, double y) {
    targetRect = Rect.fromLTWH(x, y, 2*game.tileSize, 2*game.tileSize);
    targetPaint = Paint();
    targetPaint.color = Color(0xff00f000);
  }

  void render(Canvas c) {
    //c.drawRect(targetRect, targetPaint);
    box.renderRect(c, targetRect);
  }

  void update(double t) {}

}