import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:wumpus_world/customwidget.dart';
import 'package:wumpus_world/gameengine/characters.dart';
import 'package:wumpus_world/gameengine/flag.dart';
import 'package:wumpus_world/gameengine/map.dart';
import 'package:wumpus_world/gamescreen/controller.dart';
import 'package:wumpus_world/gamescreen/gamescreen.dart';
import 'package:wumpus_world/gamescreen/mapblock.dart';
import 'package:wumpus_world/gamescreen/notifybox.dart';
import 'package:wumpus_world/gamescreen/winlosealert.dart';

class Game {
  GameMap gameMap;
  Flag flag;
  Player player;
  Wumpus wumpus;
  AnimatedText animatedText;
  DirectionController directionController;
  ActionButton actionButton;
  MapBlock mapBlock;
  PlayerCell playerCell;
  GameScreen gameScreen;
  static BuildContext context;

  Future<int> checkWinLose() async {
    if (player.pos[0] == 0 && player.pos[1] == 0 && player.carryGoal) {
      player.win = true;
      player.visitAllMap();
      mapBlock.update(() {});
      showWinDialog(context);
      actionButton.update(() {});
      return 1;
    }
    if (gameMap.map[player.pos[0]][player.pos[1]] == WUMPUS) {
      player.lose = true;
      player.visitAllMap();
      playerCell.vanish();
      mapBlock.update(() {});
      await showLoseWumpusDialog(context);
      actionButton.update(() {});
      return -1;
    }
    if (gameMap.map[player.pos[0]][player.pos[1]] == PIT) {
      player.lose = true;
      player.visitAllMap();
      mapBlock.update(() {});
      showLosePitDialog(context);
      actionButton.update(() {});
      return -2;
    }
    return 0;
  }

  Future<void> playerMove(String dir) async {
    player.move(dir: dir);
    player.active = false;
    directionController.update(() {});
    actionButton.update(() {});

    playerCell.move(dir: dir);
    await Future.delayed(Duration(milliseconds: 200));

    mapBlock.update(() {});
    directionController.update(() {});
    actionButton.update(() {});

    if (gameMap.map[player.pos[0]][player.pos[1]] == PIT) playerCell.vanish();
    animatedText.animateUntil(fulltext: flag.getSituationPlayer());
    await Future.delayed(
        Duration(milliseconds: 20 * flag.getSituationPlayer().length));

    if (await checkWinLose() != 0) return;

    if (wumpus.active) {
      await Future.delayed(Duration(milliseconds: 1500));
      wumpus.move();
      animatedText.animateUntil(fulltext: flag.getSituationWumpus());
      await Future.delayed(
          Duration(milliseconds: 20 * flag.getSituationWumpus().length));
      if (await checkWinLose() != 0) return;
    }

    player.active = true;
    directionController.update(() {});
    actionButton.update(() {});

    for (int i = 0; i < gameMap.map.length; i++) print(gameMap.map[i]);
    print('ENd turn');
  }

  Future<void> arrowMove(String dir) async {
    player.shootArrow(dir);
    player.active = false;
    directionController.update(() {});
    actionButton.update(() {});

    playerCell.shootArrow(dir: dir);
    await Future.delayed(Duration(seconds: 3));

    mapBlock.update(() {});

    animatedText.animateUntil(fulltext: flag.getSituationPlayer());
    await Future.delayed(
        Duration(milliseconds: 20 * flag.getSituationPlayer().length));

    player.active = true;
    directionController.update(() {});
    actionButton.update(() {});

    for (int i = 0; i < gameMap.map.length; i++) print(gameMap.map[i]);
    print('Arrow shot!');
  }

  Game() {
    gameMap = GameMap.randommap(
        size: 7, numOfDeads: 2, numOfPits: 20, numOfSounds: 2);
    flag = Flag();
    player = Player(pos: [0, 0], map: gameMap, flag: flag);
    wumpus = Wumpus(
        pos: gameMap.wumpusPos, map: gameMap, flag: flag, player: player);
    animatedText = AnimatedText();
    directionController = DirectionController(1, 1, 1, playerMove, player);
    actionButton = ActionButton(1, 1, 1, arrowMove, player);
    playerCell = PlayerCell(gameMap.size, player.pos[0], player.pos[1]);
    mapBlock = MapBlock(100, gameMap, playerCell, wumpus);
    if (mapBlock == null) print('Null mapblock');
    gameScreen = GameScreen(
        animatedText, directionController, actionButton, playerCell, mapBlock);
  }
}
