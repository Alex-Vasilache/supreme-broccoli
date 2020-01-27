import 'dart:async';
import 'dart:ui';

import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'box-game.dart';

Timer timer;

class MyTimer {
  int time;
  bool isFinished = false;
  final BoxGame game;
  TextConfig config;

  MyTimer(this.game, this.time) {
    config = TextConfig(fontSize: game.tileSize*4, fontFamily: 'Courier',
        textAlign: TextAlign.center, color: Color(0x20000000));
  }

  void render(Canvas c) {
    config.render(c, time.toString(),
        Position(game.screenSize.width/2 - game.tileSize*(1.25)*time.toString().length,
            game.screenSize.height/2 - game.tileSize * 8));
  }

  void addTime(int extra) {
    time += extra;
  }

  void decrement() {
    if(time > 0)
      time --;
    else {
      isFinished = true;
      timer.cancel();
      game.stopGame();
    }      
  }

  void start(){
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => decrement());
  }

}