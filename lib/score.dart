import 'dart:async';
import 'dart:ui';

import 'package:flame/components/text_box_component.dart';
import 'package:flame/palette.dart';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flame/time.dart';
import 'package:newprojectx/box-game.dart';
import 'package:newprojectx/myTimer.dart';

class Score {

  final BoxGame game;
  String textScore;
  int intScore;
  TextConfig config;
  Rect textContainer;
  Paint textContainerPaint;
  MyTimer timer;

  Score(this.game) {
    intScore = 0;
    textScore = "S: 0";
    config = TextConfig(fontSize: game.tileSize, fontFamily: 'Courier', textAlign: TextAlign.center);
    textContainer = Rect.fromLTWH(0, game.screenSize.height - 3 * game.tileSize, game.screenSize.width, 2 * game.tileSize);
    timer = MyTimer(10);
    timer.start();
    textContainerPaint = Paint();
    textContainerPaint.color = Color(0xff42c0ff);
  }

  void render(Canvas c) {

    //game.screenSize.width/2 - game.tileSize * (textScore.length/4 + 0.5)

    c.drawRect(textContainer, textContainerPaint);
    config.render(c, textScore, Position(0 , game.screenSize.height - 3/2*game.tileSize));
    
    config.render(c, timer.time.toString(), Position( game.screenSize.width- game.tileSize * (textScore.length/2 + 1),
    game.screenSize.height - 3/2*game.tileSize));
    
  }

  void update(double t) {}

  void increment() {
    intScore ++;
    textScore = "S: " + intScore.toString();
    
  }
}
