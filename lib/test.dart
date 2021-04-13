import 'dart:io';

import 'package:wumpus_world/gameengine/characters.dart';
import 'package:wumpus_world/gameengine/flag.dart';
import 'package:wumpus_world/gameengine/map.dart';

void main() {
  GameMap map = GameMap.randommap(
      size: 10, numOfPits: 30, numOfDeads: 2, numOfSounds: 10);
  Flag flag = Flag();
  Player player = Player(pos: [0, 0], map: map, flag: flag);
  Wumpus wumpus =
      Wumpus(pos: map.wumpusPos, map: map, flag: flag, player: player);

  while (true) {
    print('Player pos:' + player.pos.toString());
    for (int i = 0; i < map.map.length; i++) print(map.map[i]);
    String dir = stdin.readLineSync();
    player.move(dir: dir);
    if (flag.getSituationPlayer() != '') print(flag.getSituationPlayer());
    if (wumpus.active) {
      wumpus.move();
      if (flag.getSituationWumpus() != '') print(flag.getSituationWumpus());
    }
  }
}
