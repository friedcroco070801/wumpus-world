import 'dart:math';

import 'package:wumpus_world/gameengine/pathfinding.dart';

final int NONE = 0;
final int PIT = 1;
final int DEADBODY = 2;
final int SOUND = 3;
final int WUMPUS = 4;
final int GOAL = 5;
final int WUMPUSDEAD = 6;

class Point {
  int hash;
  int size;

  Point(List<int> pos, int size) {
    this.hash = pos[0] * size + pos[1];
    this.size = size;
  }

  @override
  bool operator <(other) {
    return (this.hash < other.hash);
  }

  @override
  bool operator ==(other) {
    return (this.hash == other.hash);
  }

  @override
  int get hashCode {
    return this.hash;
  }

  List<int> position() {
    return [this.hash ~/ this.size, this.hash % this.size];
  }

  List<List<int>> around() {
    List<List<int>> temp = [];
    List<int> pos = this.position();
    temp.add(pos);
    if (pos[0] > 0) temp.add([pos[0] - 1, pos[1]]);
    if (pos[0] < this.size - 1) temp.add([pos[0] + 1, pos[1]]);
    if (pos[1] > 0) temp.add([pos[0], pos[1] - 1]);
    if (pos[1] < this.size - 1) temp.add([pos[0], pos[1] + 1]);
    return temp;
  }

  List<List<int>> aroundAround() {
    List<List<int>> temp = this.around();
    List<int> pos = this.position();
    bool up1 = pos[0] > 0;
    bool up2 = pos[0] > 1;
    bool down1 = pos[0] < this.size - 1;
    bool down2 = pos[0] < this.size - 2;
    bool left1 = pos[1] > 0;
    bool left2 = pos[1] > 1;
    bool right1 = pos[1] < this.size - 1;
    bool right2 = pos[1] < this.size - 2;

    if (up1 && left1) temp.add([pos[0] - 1, pos[1] - 1]);
    if (up1 && right1) temp.add([pos[0] - 1, pos[1] + 1]);
    if (down1 && left1) temp.add([pos[0] + 1, pos[1] - 1]);
    if (down1 && right1) temp.add([pos[0] + 1, pos[1] + 1]);

    if (up2) temp.add([pos[0] - 2, pos[1]]);
    if (down2) temp.add([pos[0] + 2, pos[1]]);
    if (left2) temp.add([pos[0], pos[1] - 2]);
    if (right2) temp.add([pos[0], pos[1] + 2]);

    // if (up2 && left1) temp.add([pos[0] - 2, pos[1] - 1]);
    // if (up2 && right1) temp.add([pos[0] - 2, pos[1] + 1]);
    // if (down2 && left1) temp.add([pos[0] + 2, pos[1] - 1]);
    // if (down2 && right1) temp.add([pos[0] + 2, pos[1] + 1]);
    // if (left2 && up1) temp.add([pos[0] - 1, pos[1] - 2]);
    // if (left2 && down1) temp.add([pos[0] + 1, pos[1] - 2]);
    // if (right2 && up1) temp.add([pos[0] - 1, pos[1] + 2]);
    // if (right2 && down1) temp.add([pos[0] + 1, pos[1] + 2]);

    return temp;
  }
}

class GameMap {
  int size;
  List<List<int>> map;
  List<List<List<String>>> visitedMap;
  List<int> goalPos;
  List<int> wumpusPos;

  GameMap.premap({List<List<int>> map}) {
    this.map = map;
    this.size = this.map.length;
    this.visitedMap = List.generate(
        size, (index) => List.generate(size, (index) => ['Empty']));
    for (int i = 0; i < this.size; i++) {
      for (int j = 0; j < this.size; j++) {
        if (this.map[i][j] == GOAL) this.goalPos = [i, j];
        if (this.map[i][j] == WUMPUS) this.wumpusPos = [i, j];
      }
    }
  }

  GameMap.randommap(
      {int size, int numOfPits = 0, int numOfDeads = 0, int numOfSounds = 0}) {
    do {
      this.map = GameMap.generateMap(size, numOfPits, numOfDeads, numOfSounds);
      this.size = this.map.length;
      for (int i = 0; i < this.size; i++) {
        for (int j = 0; j < this.size; j++) {
          if (this.map[i][j] == GOAL) this.goalPos = [i, j];
          if (this.map[i][j] == WUMPUS) this.wumpusPos = [i, j];
        }
      }
    } while (!this._isHardEnough());
    this.visitedMap = List.generate(
        size, (index) => List.generate(size, (index) => ['Empty']));
  }

  bool isObstacle(List<int> pos) {
    int temp = this.map[pos[0]][pos[1]];
    if (temp == PIT || temp == WUMPUS)
      return true;
    else
      return false;
  }

  bool _canWin() {
    PathFinding pathFind =
        PathFinding(map: this, start: [0, 0], end: this.goalPos);
    return pathFind.solve();
  }

  bool _isHardEnough() {
    PathFinding pathFind =
        PathFinding(map: this, start: [0, 0], end: this.goalPos);
    bool canWin = pathFind.solve();
    return (canWin && pathFind.path.length >= this.size);
  }

  static List<List<int>> generateMap(
      int size, int numOfPits, int numOfDeads, int numOfSounds) {
    var ran = Random();
    // Initialize map
    List<List<int>> map = [
      for (int i = 0; i < size; i++) [for (int j = 0; j < size; j++) 0]
    ];

    // Set of all tiles
    Set<Point> all = Set<Point>();
    for (int i = 0; i < size; i++)
      for (int j = 0; j < size; j++) all.add(Point([i, j], size));

    // Initial occupied tiles
    Set<Point> occupied = Set<Point>();
    for (Point e in [
      Point([0, 0], size),
      Point([1, 0], size),
      Point([0, 1], size),
      Point([1, 1], size)
    ]) occupied.add(e);
    //print(occupied);

    // Initial deadbodys position
    Set<Point> canPlace = all.difference(occupied);
    //print(canPlace.length);
    for (int i = 0; i < numOfDeads; i++) {
      int index = ran.nextInt(canPlace.length);
      Point temp = canPlace.elementAt(index);
      occupied.add(temp);
      canPlace.remove(temp);
      List<int> pos = temp.position();
      map[pos[0]][pos[1]] = DEADBODY;
      //print(canPlace.length);
    }

    // Initial wumpus position
    {
      int index = ran.nextInt(canPlace.length);
      Point temp = canPlace.elementAt(index);
      occupied.add(temp);
      canPlace.remove(temp);
      List<int> pos = temp.position();
      map[pos[0]][pos[1]] = WUMPUS;
    }

    // Initial goal position
    {
      int index = ran.nextInt(canPlace.length);
      Point temp = canPlace.elementAt(index);
      occupied.add(temp);
      canPlace.remove(temp);
      List<int> pos = temp.position();
      map[pos[0]][pos[1]] = GOAL;
    }

    // Initial sound position
    for (int i = 0; i < numOfSounds; i++) {
      if (canPlace.length > 0) {
        int index = ran.nextInt(canPlace.length);
        Point temp = canPlace.elementAt(index);
        occupied.add(temp);
        canPlace.remove(temp);
        List<int> pos = temp.position();
        map[pos[0]][pos[1]] = SOUND;
        //print(canPlace.length);
      }
    }

    // Initial pits position
    for (int i = 0; i < numOfPits; i++) {
      if (canPlace.length > 0) {
        int index = ran.nextInt(canPlace.length);
        Point temp = canPlace.elementAt(index);
        List<List<int>> tempList = temp.aroundAround();
        //print(tempList);
        List<Point> pointList = List<Point>.generate(
            tempList.length, (i) => Point(tempList[i], size));
        occupied.addAll(pointList);
        canPlace.removeAll(pointList);
        List<int> pos = temp.position();
        map[pos[0]][pos[1]] = PIT;
        //print(canPlace.length);
      }
    }

    return map;
  }
}

// void main() {
//   GameMap a = GameMap.randommap(size: 10, numOfPits: 30);
//   for (int i = 0; i < a.map.length; i++) print(a.map[i]);
//   return;
// }
