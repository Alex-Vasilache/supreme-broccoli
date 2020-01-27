import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:newprojectx/box-game.dart';
import 'package:flutter/gestures.dart';

void main() {
  BoxGame game = BoxGame();
  Util flameUtil = Util();

  runApp(game.widget);

  flameUtil.fullScreen();
  flameUtil.setOrientation(DeviceOrientation.portraitUp);

  //Load images
  Flame.images.loadAll(<String>[
  'crosshairs_small.png',
  'start_1.png',
  'start_2.png',
  'start_3.png',
  'calibrate_1.png',
  'calibrate_2.png',
  'calibrate_3.png',
  'over.png',
  'loading.png',
  ]);
  
  //Add gesture recognizer
  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  tapper.onTapUp = game.onTapUp;
  flameUtil.addGestureRecognizer(tapper);
}