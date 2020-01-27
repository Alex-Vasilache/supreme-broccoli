import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:newprojectx/box-game.dart';

class StartButton {
  final BoxGame game;
  
  Rect textContainer;
  Sprite startDisable = Sprite('start_1.png');
  Sprite startUp =  Sprite('start_2.png');
  Sprite startDown = Sprite('start_3.png');
  Sprite calibrateUp = Sprite('calibrate_1.png');
  Sprite calibrateDown = Sprite('calibrate_2.png');
  Sprite calibrateDisable = Sprite('calibrate_3.png');
  Sprite loading = Sprite('loading.png');
  bool up;

  StartButton (this.game) {

    up = true;
    double left = 3/2*game.tileSize;
    double top = game.screenSize.height/2 - 5/2*game.tileSize;
    double width = 6*game.tileSize;
    double height = 3*game.tileSize;

    textContainer = Rect.fromLTWH(left,top,width,height);
  }

  void render(Canvas c) { 
    if(!game.bluetoothManager.connected) {
      loading.renderRect(c, textContainer);
    } else {
       if(up)
        startUp.renderRect(c,textContainer);
        else
         startDown.renderRect(c,textContainer);
    }
  }

  void update(double t) {}

  void onTapDown() {
    up = false;
  }

  void onTapUp() {
    up = true;
    textContainer = Rect.fromLTWH(0,0,0,0);
  }

}