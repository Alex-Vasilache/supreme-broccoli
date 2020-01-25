import 'dart:async';

import 'box-game.dart';

Timer timer;

class MyTimer {

  int time;
  bool isFinished = false;
  final BoxGame game;

  MyTimer(this.game, this.time);

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