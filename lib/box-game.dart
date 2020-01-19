import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:newprojectx/player.dart';

class BoxGame extends Game {
  Size screenSize;
  Player player;

  BoxGame() {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    player = Player(this, screenSize.width/2, screenSize.height/2);
  }

  void render(Canvas canvas) { 
    //Draw background
    Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xff000000);
    canvas.drawRect(bgRect, bgPaint);

    player.render(canvas);
  }

  void update(double t) {
    // TODO: implement update
  }
  

  void resize(Size size) {
    screenSize = size;
    super.resize(size);
  }

  void onSensorInput(double aAlpha, double aBeta, double aGamma, double gAlpha, double gBeta, double gGamma) {
    player.onSensorInput(aAlpha, aBeta, aGamma, gAlpha, gBeta, gGamma);
  }

  void onButtonPressed(bool button) {
    player.onButtonPressed(button);
  }
}