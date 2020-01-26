import 'dart:async';
import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newprojectx/player.dart';
import 'package:newprojectx/score.dart';
import 'package:newprojectx/startButton.dart';
import 'package:newprojectx/target.dart';
import 'dart:math';
import 'package:flutter/gestures.dart';
   

class BoxGame extends Game {
  Size screenSize;
  Player player;
  Score score;
  double tileSize;
  List<Target> targets;
  Random random;
  bool gameOver;
  StartButton startButton;
  void Function() connectBluetooth;
  bool connected = false;

  BoxGame() {
    initialize();
  }

  void initialize() async {
    await Flame.util.fullScreen();
    await Flame.util.setOrientation(DeviceOrientation.portraitUp);
    resize(await Flame.util.initialDimensions());
    Flame.images.load('crosshairs_small.png');
    Flame.images.load('start_2.png');
    Flame.images.load('start_3.png');
    Flame.images.load('over.png');
    Flame.images.load('loading.png');
    gameOver = true;
    random = Random();
    score = Score(this);
    targets = List<Target>();    
    player = Player(this, screenSize.width/2, screenSize.height/2 - tileSize);
    startButton = StartButton(this);
    /*Timer(Duration(seconds: 10), () async {
      Timer.periodic(Duration(milliseconds: 2300), (timer) async {
        if(!connected)
          connectBluetooth();
        else{
          timer.cancel();
        }
      }
      );
    }
    );*/
    spawnTarget();  
  }

  void startGame() {
    //conncetBluetooth();
    score.timer.start();
    gameOver = false;
  }

  void spawnTarget() {
    double x = random.nextDouble() * (screenSize.width - 3 * tileSize) + tileSize;
    double y = random.nextDouble() * (screenSize.height - 3 * tileSize) + tileSize;
    Target newTarget = Target(this, x,y);
    
    targets.add(newTarget);
  }

  void render(Canvas canvas) { 
    //Draw background
    Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xffffffff);
    canvas.drawRect(bgRect, bgPaint);
  
    targets.forEach((Target target) => target.render(canvas));
    player.render(canvas);
    
    score.render(canvas);
    startButton.render(canvas);
  }

  void update(double t) {
   
  }

  void stopGame() {
    gameOver = true;
    startButton = StartButton(this);
    score.timer.addTime(10);
    score.intScore = 0;
    score.textScore = "S: 0";
  }
  

  void resize(Size size) {
    screenSize = size;
    super.resize(size);
    tileSize = screenSize.width / 9;
  }

  void onSensorInput(double aAlpha, double aBeta, double aGamma, double gAlpha, double gBeta, double gGamma) {
    //TODO remove unused inputs
    if(!gameOver)
      player.onSensorInput(aAlpha, aBeta, aGamma, gAlpha, gBeta, gGamma);
  }

  void onButtonPressed(bool button) {
  }

  void onTapDown(TapDownDetails d) {
    
    if(!gameOver) {
      targets.forEach((Target target) {
      if(target.targetRect.contains(player.playerRect.center)) {
        targets.remove(target);
        score.increment();
        score.timer.addTime(3);
        spawnTarget();
      }
      });
    } else {
      if(startButton.textContainer.contains(d.globalPosition)){
        startButton.onTapDown();
      }
    }

  }

  void onTapUp(TapUpDetails d) {
    if(gameOver){
      if(startButton.textContainer.contains(d.globalPosition)){
        startButton.onTapUp();
        startGame();
      }
    }
  }

  void addStartFunction(void Function()  press) {
    connectBluetooth = press;
  }

  
}