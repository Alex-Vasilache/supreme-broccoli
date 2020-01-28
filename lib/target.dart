import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:newprojectx/shootingGame.dart';

class Target {

  final ShootingGame game;  
  Rect targetRect;
  Sprite box =  Sprite('box.png');

  Target(this.game, double x, double y) {
    targetRect = Rect.fromLTWH(x, y, 2*game.tileSize, 2*game.tileSize);
  }

  void render(Canvas c) {
    box.renderRect(c, targetRect);
  }

  void update(double t) {}

}