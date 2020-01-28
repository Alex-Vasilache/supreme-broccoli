import 'dart:ui';

import 'dart:math';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:newprojectx/shootingGame.dart';

class ConnectionStatus {
  final ShootingGame game;
  String hint;
  String status = " ";
  String entireText;
  TextConfig config;
  int lineLength;

  ConnectionStatus(this.game) {
    hint = "Searching for eSense device..." + "\n" +
        "Please make sure it is turned on!";
    config = TextConfig(fontSize: game.tileSize/3, fontFamily: 'Courier',
        textAlign: TextAlign.center);
    generateText();
  }

  void render(Canvas c) {
    generateText();
    config.render(c, entireText,
        Position(game.screenSize.width/2 - game.tileSize/3 * (lineLength/4 + 1.5),
            game.screenSize.height/2 + game.tileSize/2));
  }

  void updateStatus(String s) {
    status = "Status: " + s;
  }
  
  void getLengthOfLongestLine() {
    lineLength =  entireText.split("\n").fold(0, (prev, element) =>
        max<int>(prev, element.length));
  }

  void generateText() {
    if(!game.bluetoothManager.connected)
      entireText = hint + "\n\n" + status;
    else {
      if(!game.player.setUp) {
        entireText = "Keep your head in a neutral position," + "\n" +
                     "then press Calibrate Sensor and hold"  + "\n" +
                     "still for 3 seconds, while the" + "\n" +
                     "sensor calibrates";
      } else {
        entireText = "";
      }
    }
    getLengthOfLongestLine();
  }

  void update(double t) {}
}
