import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wumpus_world/data/gamedata.dart';
import 'package:wumpus_world/gamescreen/colorpallete.dart';
import 'package:wumpus_world/gamescreen/game.dart';
import 'package:wumpus_world/gamescreen/gamescreen.dart';
import 'package:wumpus_world/mainscreen/mainscreen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() {
  Stream<dynamic> getData = () async* {
    if (!kIsWeb) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      GameData.maxLevel = prefs.getInt('maxLevel');
      if (GameData.maxLevel == null) {
        print('No data');
        GameData.maxLevel = 1;
        print(GameData.maxLevel);
      }
    } else
      GameData.maxLevel = 1;
    GameData.level = GameData.maxLevel;
  }();

  runApp(MaterialApp(
    home: () {
      return StreamBuilder<dynamic>(
          stream: getData,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: GameColor.ONYX,
              );
            } else
              return MainScreen();
          });
    }(),
  ));
}
