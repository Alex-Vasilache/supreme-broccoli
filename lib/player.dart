import 'dart:ui';
import 'package:newprojectx/box-game.dart';

class Player {

  final BoxGame game;
  Rect playerRect;
  Paint playerPaint;
  double middleX;
  double middleY;

  Player(this.game, double x, double y) {
    middleX = x;
    middleY = y;
    playerRect = Rect.fromLTWH(x - 10, y - 10, 20, 20);
    playerPaint = Paint();
    playerPaint.color = Color(0xffffffff);
  }

  void render(Canvas c) {
    c.drawRect(playerRect, playerPaint);
  }

  void update(double t){
    
  }

  void onSensorInput(double aAlpha, double aBeta, double aGamma,double gAlpha, double gBeta, double gGamma) {
    if(isInside(gAlpha, 0))
      playerRect = playerRect.translate(gAlpha, 0);

     if(isInside(0, gGamma))
      playerRect = playerRect.translate(0, gGamma + 1.6);
    
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