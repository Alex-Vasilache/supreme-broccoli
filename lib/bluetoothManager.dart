import 'dart:async';
import 'dart:ui';

import 'package:esense_flutter/esense.dart';
import 'package:newprojectx/box-game.dart';

class BluetoothManager {

  final BoxGame game;
  bool connected = false;
  String eSenseName = 'eSense-0414';
  String _deviceStatus = '';

  BluetoothManager(this.game) {
    _connectToESense();
  }
    
  void render(Canvas c) {}
    
  void update(double t) {}
    
  Future<void> _connectToESense() async {
    ESenseManager.connectionEvents.listen((event) {
      print('CONNECTION event: $event');

      if(event.type == ConnectionType.connected) {}

      switch (event.type) {
          case ConnectionType.connected:
            _deviceStatus = 'connected';
            break;
          case ConnectionType.unknown:
            _deviceStatus = 'unknown';
            break;
          case ConnectionType.disconnected:
            _deviceStatus = 'disconnected';
            break;
          case ConnectionType.device_found:
            _deviceStatus = 'device_found';
            break;
          case ConnectionType.device_not_found:
            _deviceStatus = 'device_not_found';
            break;
        }
    });

    Timer.periodic(Duration(seconds: 2), (timer) async {
      connected = await ESenseManager.connect(eSenseName);
      if(_deviceStatus == 'device_found') {
        timer.cancel();
      }
    });

    print(connected);
  }

}