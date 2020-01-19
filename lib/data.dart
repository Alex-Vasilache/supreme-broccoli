import 'dart:async';

import 'package:flutter/material.dart';
import 'package:newprojectx/eSense.dart' as eSense;

class DataTab extends StatefulWidget {
  @override
  _DataTabState createState() => _DataTabState();
}

class _DataTabState extends State<DataTab> with AutomaticKeepAliveClientMixin {
    String _accl = eSense.getAccl();
    String _gyro = eSense.getGyro();    
    bool _button = eSense.getButtonStatus();
    int _aAlpha;
    int _aBeta;
    int _aGamma;
    int _gAlpha;
    int _gBeta;
    int _gGamma;
    
  @override
  void initState() {
    super.initState();
    refresh();
  }

  void refresh() {
    Timer.periodic(Duration(milliseconds: 10), (timer) async => await getSensorData());
  }

  

  Future<void> getSensorData() async {
      setState(() {
        _accl = eSense.getAccl();
        _aAlpha = (int.parse(_accl.substring(_accl.indexOf("[") + 1, _accl.indexOf(",")))/100).ceil();
        _aBeta = (int.parse(_accl.substring(_accl.indexOf(",") + 1, _accl.lastIndexOf(",")))/100).ceil();
        _aGamma = (int.parse(_accl.substring(_accl.lastIndexOf(",") + 1, _accl.lastIndexOf("]")))/100).ceil();
        _gyro = eSense.getGyro();
        _gAlpha = (int.parse(_gyro.substring(_gyro.indexOf("[") + 1, _gyro.indexOf(",")))/100).ceil();
        _gBeta = (int.parse(_gyro.substring(_gyro.indexOf(",") + 1, _gyro.lastIndexOf(",")))/100).ceil();
        _gGamma = (int.parse(_gyro.substring(_gyro.lastIndexOf(",") + 1, _gyro.lastIndexOf("]")))/100).ceil();
        _button = eSense.getButtonStatus();
        
      });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      
        body: Align(
          alignment: Alignment.topLeft,
          child: ListView(
            children: [
              Text('aAlpha: $_aAlpha'),
              Text('aBeta: $_aBeta'),
              Text('aGamma: $_aGamma'),
              Text('gAlpha: $_gAlpha'),
              Text('gBeta: $_gBeta'),
              Text('gGamma: $_gGamma'),
              Text('button pressed: $_button')
            ],
          ),
        ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}