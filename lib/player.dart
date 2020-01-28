import 'dart:ui';
import 'package:newprojectx/box-game.dart';
import 'package:flame/sprite.dart';

class Player {
  final BoxGame game;
  Rect playerRect;
  double sensitivity = 0.5;
  Sprite crosshair =  Sprite('crosshairs_small.png');
  bool setUp = false;
  bool calibrationPhase = false;
  int size = 4;
  List<double> initialPos = List(2);
  List<List<double>> position = List(2);
  List<List<double>> calibratePosition = List(2);
  List<double> average = List(2);
  List<double> oldTrans = List(2);

  Player(this.game, double x, double y) {

    playerRect = Rect.fromLTWH(x - game.tileSize, y - game.tileSize, game.tileSize*2, game.tileSize*2);
    position[0] = List(size);
    position[1] = List(size);
    for(var i = 0; i < size; i++) {
      position[0][i] = 0;
      position[1][i] = 0;
    }
    calibratePosition[0] = new List();
    calibratePosition[1] = new List();
    initialPos[0] = 0;
    initialPos[1] = 0;
  }

  void render(Canvas c) {
    crosshair.renderRect(c, playerRect);
  }

  void update(double t) {
    //sensitivity = 0.5;
    average = getAvgPosition(position);
    average[0] -= initialPos[0];
    average[1] -= initialPos[1];
    //X coordinate
    if(isInside(average[0]*sensitivity, 0))
      playerRect = playerRect.translate(average[0]*sensitivity, 0);
    //Y coordinate
    if(isInside(0, average[1]*sensitivity))
      playerRect = playerRect.translate(0, average[1]*sensitivity);
  }

  bool isInside(double x, double y) {
    if(playerRect.bottom + y > game.screenSize.height) {return false;}
    if(playerRect.right + x > game.screenSize.width) {return false;}
    if(playerRect.top + y < 0) {return false;}
    if(playerRect.left + x < 0) {return false;}
    
    return true;
  }

  void finishCalibration() {
    if(calibrationPhase) {
      calibrationPhase = false;
      setUp = true;
      initialPos = getAvgPosition(calibratePosition);
      //oldTrans = initialPos;
    }
  }

  void setUpSensor(List<double> accl, List<double> gyro) {
     
      if (calibrationPhase) {
        calibratePosition[0].add(gyro[0]);
        calibratePosition[1].add(gyro[2]);
      }
      
      /*
    if (calibrationPhase) {
      calibratePosition[0].add(accl[2]);
      calibratePosition[1].add(accl[1]);
    }*/
  }

  void onSensorEvent(List<double> accl, List<double> gyro) {

    
    addValues(gyro[0], gyro[2], position);
    
     
    /*
    List<double> newTrans = List(2);
    newTrans[0] = (accl[2] - oldTrans[0]) *(-1);
    newTrans[1] = accl[1] - oldTrans[1];

    if(isInside(newTrans[0]*sensitivity, 0))
      playerRect = playerRect.translate(newTrans[0]*sensitivity, 0);
    if(isInside(0, newTrans[1]*sensitivity))
      playerRect = playerRect.translate(0, newTrans[1]*sensitivity);

    oldTrans[0] = accl[2];
    oldTrans[1] = accl[1];
    */
  }


  void addValues(double x, double y, List<List<double>> vec) {
    for (var i = 0; i < vec[0].length - 1; i++) {
      vec[0][i] = vec[0][i+1];
      vec[1][i] = vec[1][i+1];
    }
    vec[0][vec[0].length - 1] = x;
    vec[1][vec[1].length - 1] = y;
  }

  List<double> getAvgPosition(List<List<double>> vec) {
    List<double> avg = List(2);
    avg[0] = vec[0].reduce((current, next) => current + next)/vec[0].length;
    avg[1] = vec[1].reduce((current, next) => current + next)/vec[1].length;
    return avg;
  }
}