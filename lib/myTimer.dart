import 'dart:async';

Timer timer;

class MyTimer {

  int time;
  bool isFinished = false;

  MyTimer(this.time);

  void addTime(int extra) {
    time += extra;
  }

  void decrement() {
    if(time > 0)
      time --;
    else
      isFinished = true;
  }

  void start(){
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => decrement());
  }

}