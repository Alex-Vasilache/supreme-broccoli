import 'dart:ui';
import 'package:newprojectx/box-game.dart';
import 'package:flame/sprite.dart';

class Player {

  final BoxGame game;
  Rect playerRect;
  double middleX;
  double middleY;
  double sensitivity = 1.5;
  Sprite crosshair =  Sprite('crosshairs_small.png');

  Player(this.game, double x, double y) {
    middleX = x;
    middleY = y;
    playerRect = Rect.fromLTWH(x - game.tileSize, y - game.tileSize, game.tileSize*2, game.tileSize*2);
  }

  void render(Canvas c) {
    //c.drawRect(playerRect, playerPaint);
    crosshair.renderRect(c, playerRect);
  }

  void update(double t){
    
  }

  void onSensorInput(double aAlpha, double aBeta, double aGamma,double gAlpha, double gBeta, double gGamma) {

    //Todo try with acceleration

    if(isInside(sensitivity * gAlpha, 0)){
      playerRect = playerRect.translate(sensitivity * gAlpha, 0);
      middleX = middleX + sensitivity * gAlpha;
    }
      

     if(isInside(0, sensitivity * gGamma)) {
       playerRect = playerRect.translate(0, sensitivity * gGamma + 1.6);
       middleY = middleY + sensitivity * gGamma + 1.6;
     }
      
    
  }

  bool isInside(double x, double y){
    
    if(playerRect.bottom + y > game.screenSize.height) {return false;}
    if(playerRect.right + x > game.screenSize.width) {return false;}
    if(playerRect.top + y < 0) {return false;}
    if(playerRect.left + x < 0) {return false;}
    
    return true;
  }

  void onButtonPressed(bool button) {
     
  }

  void onSensorEvent(List<double> accl, List<double> gyro) {
    
    if(isInside(sensitivity * gyro[0], 0)){
      playerRect = playerRect.translate(sensitivity * gyro[0], 0);
      middleX = middleX + sensitivity * gyro[0];
    }
      

     if(isInside(0, sensitivity * gyro[2])) {
       playerRect = playerRect.translate(0, sensitivity * gyro[2] + 1.6);
       middleY = middleY + sensitivity * gyro[2] + 1.6;
     }
  }

}