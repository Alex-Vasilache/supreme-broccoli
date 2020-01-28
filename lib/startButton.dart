import 'dart:async';
import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:newprojectx/shootingGame.dart';

class StartButton {
  final ShootingGame game;
  Rect textContainer;
  Sprite startDisable = Sprite('start_1.png');
  Sprite startUp =  Sprite('start_2.png');
  Sprite startDown = Sprite('start_3.png');
  Sprite calibrateUp = Sprite('calibrate_1.png');
  Sprite calibrateDown = Sprite('calibrate_2.png');
  Sprite calibrateDisable = Sprite('calibrate_3.png');
  Sprite loading = Sprite('loading.png');
  bool up;
  bool start = false;
  double left;
  double top;
  double width;
  double height;

  StartButton (this.game) {
    up = true;
    left = 3/2*game.tileSize;
    top = game.screenSize.height/2 - 5/2*game.tileSize;
    width = 6*game.tileSize;
    height = 3*game.tileSize;
    textContainer = Rect.fromLTWH(left,top,width,height);
  }

  void reStart() {
    textContainer = Rect.fromLTWH(left,top,width,height);
    start = false;
  }

  void render(Canvas c) { 
    if(!game.bluetoothManager.connected) {
      loading.renderRect(c, textContainer);
    } else { //Bluetooth connected
      if(!game.player.setUp) { //Calibration not set up
        if(!game.player.calibrationPhase) { //Not started calibrating
          if(up)
            calibrateUp.renderRect(c,textContainer);
          else
            calibrateDown.renderRect(c,textContainer);
        } else { //started calibrating
          if(up)
            calibrateDisable.renderRect(c,textContainer);
        }
      } else { //Calibration set up
        if(!start) {
          if(up)
            startUp.renderRect(c,textContainer);
          else
            startDown.renderRect(c,textContainer);
        } else {
          startDisable.renderRect(c,textContainer);
        }
      }
    }
  }

  void update(double t) {}

  void onTapDown() {
    up = false;
  }

  void onTapUp() {
    up = true;
    if(game.bluetoothManager.connected) {
      if(!game.player.setUp) {
        if(!game.player.calibrationPhase) { //Not started calibrating
          game.player.calibrationPhase = true;
          game.timer.start();
        } else { //started calibrating
          }
      } else { //Calibration set up
          start = true;
          Timer(Duration(milliseconds: 500), () async {
            game.startGame();
            textContainer = Rect.fromLTWH(0,0,0,0);
            });
        }
    }
  }
}