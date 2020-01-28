import 'dart:ui';

import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:newprojectx/shootingGame.dart';

class Score {
  final ShootingGame game;
  String textScore;
  String textHighScore;
  int intScore;
  int highScore;
  TextConfig config;

  Score(this.game) {
    intScore = 0;
    highScore = 0;
    textScore = "S: 0";
    textHighScore = "HS: 0";
    config = TextConfig(fontSize: game.tileSize, fontFamily: 'Courier', textAlign: TextAlign.center);
  }

  void reStart() {
    if(intScore > highScore) {
      highScore = intScore;
      textHighScore = "HS: " + highScore.toString();
    }
    intScore = 0;
    textScore = "S: 0";
  }

  void render(Canvas c) {
    config.render(c, textScore, Position(game.tileSize/2,
        game.screenSize.height - 3/2*game.tileSize));
    config.render(c, textHighScore, Position( game.screenSize.width - game.tileSize
        * (textHighScore.length/2 + 1), game.screenSize.height - 3/2*game.tileSize));
  }

  void update(double t) {}

  void increment() {
    intScore ++;
    textScore = "S: " + intScore.toString();
  }
}
