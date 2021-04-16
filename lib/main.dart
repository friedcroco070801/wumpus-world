import 'package:flutter/material.dart';
import 'package:wumpus_world/gamescreen/game.dart';
import 'package:wumpus_world/gamescreen/gamescreen.dart';

void main() {
  runApp(MaterialApp(
    home: () {
      Game game = Game();
      return game.gameScreen;
    }(),
  ));
}
