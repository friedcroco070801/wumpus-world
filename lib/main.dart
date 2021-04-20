import 'package:flutter/material.dart';
import 'package:wumpus_world/gamescreen/game.dart';
import 'package:wumpus_world/gamescreen/gamescreen.dart';
import 'package:wumpus_world/mainscreen/mainscreen.dart';

void main() {
  runApp(MaterialApp(
    home: () {
      return MainScreen();
    }(),
  ));
}
