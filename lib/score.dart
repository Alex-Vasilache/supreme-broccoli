import 'dart:ui';

import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:newprojectx/box-game.dart';

class Score {
  final BoxGame game;
  String textScore;
  int intScore;
  TextConfig config;

  Score(this.game) {
    intScore = 0;
    textScore = "S: 0";
    config = TextConfig(fontSize: game.tileSize, fontFamily: 'Courier', textAlign: TextAlign.center);
  }

  void render(Canvas c) {
    //game.screenSize.width/2 - game.tileSize * (textScore.length/4 + 0.5)
    config.render(c, textScore, Position(0 , game.screenSize.height - 3/2*game.tileSize));
  }

  void update(double t) {}

  void increment() {
    intScore ++;
    textScore = "S: " + intScore.toString();
  }
}
