import 'dart:ui';

import 'package:esense_flutter/esense.dart';
import 'package:newprojectx/box-game.dart';

class BluetoothManager {

  final BoxGame game;
  bool connected = false;
  String eSenseName = 'eSense-0414';

  BluetoothManager(this.game) {
    _connectToESense();
  }
    
  void render(Canvas c) {}
    
  void update(double t) {}
    
  Future<void> _connectToESense() async {
    ESenseManager.connectionEvents.listen((event) {
      print('CONNECTION event: $event');
      if(event.type == ConnectionType.connected) {}
    });

    connected = await ESenseManager.connect(eSenseName);
    print(connected);
  }

}