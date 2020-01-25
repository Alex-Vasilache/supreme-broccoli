import 'dart:ui';
import 'package:newprojectx/box-game.dart';
import 'package:flame/sprite.dart';

class Player {

  final BoxGame game;
  Rect playerRect;
  double middleX;
  double middleY;
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
    if(isInside(gAlpha, 0)){
      playerRect = playerRect.translate(gAlpha, 0);
      middleX = middleX + gAlpha;
    }
      

     if(isInside(0, gGamma)) {
       playerRect = playerRect.translate(0, gGamma + 1.6);
       middleY = middleY + gGamma + 1.6;
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

}