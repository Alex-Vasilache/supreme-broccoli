import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:esense_flutter/esense.dart';
import 'package:newprojectx/box-game.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _deviceName = 'Unknown';
  double _voltage = -1;
  String _deviceStatus = '';
  bool sampling = false;
  String _event = '';
  String _timestamp = '';
  int _packetIndex;
  String _accl = '';
  String _gyro = '';
  bool _button = false;
  int _aAlpha;
  int _aBeta;
  int _aGamma;
  int _gAlpha;
  int _gBeta;
  int _gGamma;

  // the name of the eSense device to connect to -- change this to your own device.
  String eSenseName = 'eSense-0414';

  @override
  void initState() {
    super.initState();
    _connectToESense();
  }

  Future<void> _connectToESense() async {
    bool con = false;

    // if you want to get the connection events when connecting, set up the listener BEFORE connecting...
    ESenseManager.connectionEvents.listen((event) {
      print('CONNECTION event: $event');

      // when we're connected to the eSense device, we can start listening to events from it
      if (event.type == ConnectionType.connected) _listenToESenseEvents();

      setState(() {
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
    });

    con = await ESenseManager.connect(eSenseName);

    setState(() {
      _deviceStatus = con ? 'connecting' : 'connection failed';
    });
  }

  void _listenToESenseEvents() async {
    ESenseManager.eSenseEvents.listen((event) {
      print('ESENSE event: $event');

      setState(() {
        switch (event.runtimeType) {
          case DeviceNameRead:
            _deviceName = (event as DeviceNameRead).deviceName;
            break;
          case BatteryRead:
            _voltage = (event as BatteryRead).voltage;
            break;
          case ButtonEventChanged:
            _button = (event as ButtonEventChanged).pressed ? true : false;
            break;
          case AccelerometerOffsetRead:
          // TODO
            break;
          case AdvertisementAndConnectionIntervalRead:
          // TODO
            break;
          case SensorConfigRead:
          // TODO
            break;
        }
      });
    });

    _getESenseProperties();
  }

  void _getESenseProperties() async {
    // get the battery level every 10 secs
    Timer.periodic(Duration(seconds: 10), (timer) async => await ESenseManager.getBatteryVoltage());

    // wait 2, 3, 4, 5, ... secs before getting the name, offset, etc.
    // it seems like the eSense BTLE interface does NOT like to get called
    // several times in a row -- hence, delays are added in the following calls
    Timer(Duration(seconds: 2), () async => await ESenseManager.getDeviceName());
    Timer(Duration(seconds: 3), () async => await ESenseManager.getAccelerometerOffset());
    Timer(Duration(seconds: 4), () async => await ESenseManager.getAdvertisementAndConnectionInterval());
    Timer(Duration(seconds: 5), () async => await ESenseManager.getSensorConfig());
  }

  StreamSubscription subscription;
  void _startListenToSensorEvents() async {
    // subscribe to sensor event from the eSense device
    subscription = ESenseManager.sensorEvents.listen((event) {
      print('SENSOR event: $event');
      setState(() {
        _event = event.toString();
        _timestamp = _event.substring(_event.indexOf("timestamp: ") + 11, _event.indexOf("packetIndex") - 2);
        _packetIndex = int.parse(_event.substring(_event.indexOf("packetIndex: ") + 13 ,_event.indexOf("accl:") - 2));
        _accl = _event.substring(_event.indexOf("accl: ") + 6 , _event.indexOf("gyro:") - 2);
        _gyro = _event.substring(_event.indexOf("gyro: ") + 6);
        _aAlpha = (int.parse(_accl.substring(_accl.indexOf("[") + 1, _accl.indexOf(",")))/100).ceil();
        _aBeta = (int.parse(_accl.substring(_accl.indexOf(",") + 1, _accl.lastIndexOf(",")))/100).ceil();
        _aGamma = (int.parse(_accl.substring(_accl.lastIndexOf(",") + 1, _accl.lastIndexOf("]")))/100).ceil();
        _gAlpha = (int.parse(_gyro.substring(_gyro.indexOf("[") + 1, _gyro.indexOf(",")))/100).ceil();
        _gBeta = (int.parse(_gyro.substring(_gyro.indexOf(",") + 1, _gyro.lastIndexOf(",")))/100).ceil();
        _gGamma = (int.parse(_gyro.substring(_gyro.lastIndexOf(",") + 1, _gyro.lastIndexOf("]")))/100).ceil();
      });
    });
    setState(() {
      sampling = true;
    });
  }

  void _pauseListenToSensorEvents() async {
    subscription.cancel();
    setState(() {
      sampling = false;
    });
  }

  void dispose() {
    _pauseListenToSensorEvents();
    ESenseManager.disconnect();
    super.dispose();
  }

  Widget build(BuildContext context) {
    BoxGame game = BoxGame();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('eSense Demo App'),
        ),
        body: game.widget,
        drawer: Drawer(
          child: ListView(
            children: [
              Text('eSense Device Status: \t$_deviceStatus'),
              Text('eSense Device Name: \t$_deviceName'),
              Text('eSense Battery Level: \t$_voltage'),
              Text('eSense Button Event: \t$_button'),
              Text(''),
              Text('$_event'),
              Text(''),
              Text('aAlpha: $_aAlpha'),
              Text('aBeta: $_aBeta'),
              Text('aGamma: $_aGamma'),
              Text(''),
              Text('gAlpha: $_gAlpha'),
              Text('gBeta: $_gBeta'),
              Text('gGamma: $_gGamma'),
              new  FloatingActionButton(
                // a floating button that starts/stops listening to sensor events.
                // is disabled until we're connected to the device.
                onPressed:
                (!ESenseManager.connected) ? null : (!sampling) ? _startListenToSensorEvents : _pauseListenToSensorEvents,
                tooltip: 'Listen to eSense sensors',
                child: (!sampling) ? Icon(Icons.play_arrow) : Icon(Icons.pause),
              )
              ],
            
            ),
        
          ),
       ),
      );
    }
}