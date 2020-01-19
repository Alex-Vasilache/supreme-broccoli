import 'package:flutter/material.dart';
import 'package:newprojectx/data.dart';
import 'package:newprojectx/eSense.dart';
import 'package:newprojectx/box-game.dart';

void main() => runApp(TabBarPage());

class TabBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    BoxGame game = BoxGame();

    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: Text('Tabs Demo'),
          ),
          body: TabBarView(
            children: [
              ESense(),
              DataTab(),
              game.widget,
            ],
          ),
        ),
      ),
    );
  }
}