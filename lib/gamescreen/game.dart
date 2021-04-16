import 'dart:async';

import 'package:wumpus_world/gameengine/characters.dart';
import 'package:wumpus_world/gameengine/flag.dart';
import 'package:wumpus_world/gameengine/map.dart';
import 'package:wumpus_world/gamescreen/controller.dart';
import 'package:wumpus_world/gamescreen/gamescreen.dart';
import 'package:wumpus_world/gamescreen/mapblock.dart';
import 'package:wumpus_world/gamescreen/notifybox.dart';

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

  void playerMove(String dir) {
    player.move(dir: dir);
    playerCell.move(dir: dir);
    mapBlock.update(() {});
    animatedText.animateUntil(fulltext: flag.getSituationPlayer());
    if (wumpus.active) {
      Timer(Duration(seconds: 2), () {
        wumpus.move();
        animatedText.animateUntil(fulltext: flag.getSituationWumpus());
      });
    }
    for (int i = 0; i < gameMap.map.length; i++) print(gameMap.map[i]);
    print('ENd turn');
  }

  Game() {
    gameMap = GameMap.randommap(
        size: 10, numOfDeads: 2, numOfPits: 20, numOfSounds: 4);
    flag = Flag();
    player = Player(pos: [0, 0], map: gameMap, flag: flag);
    wumpus = Wumpus(
        pos: gameMap.wumpusPos, map: gameMap, flag: flag, player: player);
    animatedText = AnimatedText();
    directionController = DirectionController(1, 1, 1, playerMove);
    actionButton = ActionButton(1, 1, 1);
    playerCell = PlayerCell(gameMap.size, player.pos[0], player.pos[1]);
    mapBlock = MapBlock(100, gameMap, playerCell);
    if (mapBlock == null) print('Null mapblock');
    gameScreen = GameScreen(
        animatedText, directionController, actionButton, playerCell, mapBlock);
  }
}
