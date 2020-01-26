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
    config = TextConfig(fontSize: game.tileSize, fontFamily: 'Courier', textAlign: TextAlign.center);
  }

  void render(Canvas c) {
    config.render(c, time.toString(), Position( game.screenSize.width- game.tileSize * (time.toString().length/2 + 0.5),
    game.screenSize.height - 3/2*game.tileSize));
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