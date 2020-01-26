import 'dart:ui';
import 'package:newprojectx/box-game.dart';
import 'package:flame/sprite.dart';

class Player {
  final BoxGame game;
  Rect playerRect;
  double sensitivity = 3;
  Sprite crosshair =  Sprite('crosshairs_small.png');
  bool setUp = false;
  int tempSize = 0;
  int size = 3;
  List<double> initialPos = List(2);
  List<List<double>> position = List(2);

  Player(this.game, double x, double y) {
    playerRect = Rect.fromLTWH(x - game.tileSize, y - game.tileSize, game.tileSize*2, game.tileSize*2);
    position[0] = List(size);
    position[1] = List(size);
  }

  void render(Canvas c) {
    crosshair.renderRect(c, playerRect);
  }

  void update(double t) {}

  bool isInside(double x, double y){
    
    if(playerRect.bottom + y > game.screenSize.height) {return false;}
    if(playerRect.right + x > game.screenSize.width) {return false;}
    if(playerRect.top + y < 0) {return false;}
    if(playerRect.left + x < 0) {return false;}
    
    return true;
  }

  void setUpSensor(List<double> accl, List<double> gyro) {
    if(tempSize < size) {
      addValues(gyro[0], gyro[2]);
      tempSize ++;
    } else {
      initialPos = getAvgPosition();
      setUp = true;
      tempSize = 0;
    }    
  }

  void onSensorEvent(List<double> accl, List<double> gyro) {
  
    addValues(gyro[0], gyro[2]);
    List<double> average = getAvgPosition();
    average[0] -= initialPos[0];
    average[1] -= initialPos[1];
    if(isInside(average[0]*sensitivity, 0))
      playerRect = playerRect.translate(average[0]*sensitivity, 0);
    if(isInside(0, average[1]*sensitivity))
      playerRect = playerRect.translate(0, average[1]*sensitivity);
    //print("X: " + xDiff.toString() + " Y: " + ( yDiff).toString());
    print(playerRect.center.dx);
    print(playerRect.center.dy);

  }

  void recalibrateSensor() { 
    setUp = false;
  }

  void addValues(double x, double y) {

    for (var i = 0; i < size - 1; i++) {
      position[0][i] = position[0][i+1];
      position[1][i] = position[1][i+1];
    }
    position[0][size - 1] = x;
    position[1][size - 1] = y;
  }

  List<double> getAvgPosition() {
    List<double> avg = List(2);
    avg[0] = position[0].reduce((current, next) => current + next)/size;
    avg[1] = position[1].reduce((current, next) => current + next)/size;
    return avg;
  }

}