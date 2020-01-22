import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newprojectx/player.dart';
import 'package:newprojectx/target.dart';
import 'dart:math';
import 'package:flutter/gestures.dart';
   

class BoxGame extends Game {
  Size screenSize;
  Player player;
  double tileSize;
  List<Target> targets;
  Random random;
  Text textScore = Text('Score: 0');
  int intScore;

  BoxGame() {
    initialize();
  }

  void initialize() async {
    await Flame.util.fullScreen();
    await Flame.util.setOrientation(DeviceOrientation.portraitUp);
    resize(await Flame.util.initialDimensions());
    Flame.images.load('crosshairs_small.png');

    intScore = 0;

    random = Random();
    targets = List<Target>();
    spawnTarget();
    
    player = Player(this, screenSize.width/2, screenSize.height/2 - tileSize);

  }

  void spawnTarget() {
    double x = random.nextDouble() * (screenSize.width - 3 * tileSize) + tileSize;
    double y = random.nextDouble() * (screenSize.height - 3 * tileSize) + tileSize;
    Target newTarget = Target(this, x, y);
    
    targets.add(newTarget);
    
  }

  void render(Canvas canvas) { 
    //Draw background
    Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint();
    
    bgPaint.color = Color(0xffffff00);
    canvas.drawRect(bgRect, bgPaint);
       
    targets.forEach((Target target) => target.render(canvas));
    player.render(canvas);
  }

  void update(double t) {
    targets.forEach((Target target) => target.update(t));
  }
  

  void resize(Size size) {
    screenSize = size;
    super.resize(size);
    tileSize = screenSize.width / 9;
  }

  void onSensorInput(double aAlpha, double aBeta, double aGamma, double gAlpha, double gBeta, double gGamma) {
    //TODO remove unused inputs
    player.onSensorInput(aAlpha, aBeta, aGamma, gAlpha, gBeta, gGamma);
  }

  void onButtonPressed(bool button) {
  }

  void onTapDown(TapDownDetails d) {
    
     targets.forEach((Target target) {
      if(target.targetRect.contains(player.playerRect.center)) {
        targets.remove(target);
        intScore ++;
        textScore = Text('Score: ' + intScore.toString());
        spawnTarget();
      }
      
    });
  }
  
}