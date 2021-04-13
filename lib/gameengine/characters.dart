import 'package:wumpus_world/gameengine/flag.dart';
import 'package:wumpus_world/gameengine/map.dart';
import 'package:wumpus_world/gameengine/pathfinding.dart';

class Character {
  List<int> pos = [];
  GameMap map;
  bool active;
  Flag flag;

  Character({List<int> pos, GameMap map, Flag flag}) {
    this.pos = pos;
    this.map = map;
    this.flag = flag;
  }

  bool canMove({String dir}) {
    List<int> newPos = [0, 0];
    if (dir == 'u') {
      newPos = [pos[0] - 1, pos[1]];
    } else if (dir == 'd') {
      newPos = [pos[0] + 1, pos[1]];
    } else if (dir == 'l') {
      newPos = [pos[0], pos[1] - 1];
    } else if (dir == 'r') {
      newPos = [pos[0], pos[1] + 1];
    } else
      throw ("Invalid direction");

    if (newPos[0] < 0 ||
        newPos[0] >= this.map.size ||
        newPos[1] < 0 ||
        newPos[1] >= this.map.size) {
      return false;
    } else if (this.map.isObstacle(newPos))
      return false;
    else
      return true;
  }

  bool _around(int check) {
    if (this.pos[0] > 0) if (this.map.map[this.pos[0] - 1][this.pos[1]] ==
        check) return true;
    if (this.pos[1] > 0) if (this.map.map[this.pos[0]][this.pos[1] - 1] ==
        check) return true;
    if (this.pos[0] < this.map.size - 1) if (this.map.map[this.pos[0] + 1]
            [this.pos[1]] ==
        check) return true;
    if (this.pos[1] < this.map.size - 1) if (this.map.map[this.pos[0]]
            [this.pos[1] + 1] ==
        check) return true;
    return false;
  }
}

class Player extends Character {
  bool lose;
  bool carryGoal;
  bool arrow;
  Wumpus wumpus;

  Player({List<int> pos, GameMap map, Flag flag}) {
    this.pos = pos;
    this.map = map;
    this.active = true;
    this.lose = false;
    this.carryGoal = false;
    this.flag = flag;
    this.arrow = true;
  }

  @override
  List<int> move({String dir}) {
    List<int> newPos = [0, 0];
    if (dir == 'u') {
      newPos = [pos[0] - 1, pos[1]];
    } else if (dir == 'd') {
      newPos = [pos[0] + 1, pos[1]];
    } else if (dir == 'l') {
      newPos = [pos[0], pos[1] - 1];
    } else if (dir == 'r') {
      newPos = [pos[0], pos[1] + 1];
    } else
      throw ("Invalid direction");
    this.pos = newPos;
    this._triggerEventOnMove();
    return newPos;
  }

  void _triggerEventOnMove() {
    bool meetWumpus = false;
    bool meetWumpusDead = false;
    bool meetDeadBody = false;
    bool meetBreeze = false;
    bool meetStench = false;
    bool meetSound = false;
    bool meetPit = false;
    bool meetGoal = false;
    bool startToMove = false;

    if (this.map.map[this.pos[0]][this.pos[1]] == WUMPUS) meetWumpus = true;
    if (this.map.map[this.pos[0]][this.pos[1]] == WUMPUSDEAD)
      meetWumpusDead = true;
    if (this.map.map[this.pos[0]][this.pos[1]] == DEADBODY) meetDeadBody = true;
    if (this.map.map[this.pos[0]][this.pos[1]] == SOUND) {
      meetSound = true;
      if (!this.wumpus.active) {
        this.wumpus.active = true;
        startToMove = true;
        this.map.map[this.pos[0]][this.pos[1]] = 0;
      }
    }
    if (this.map.map[this.pos[0]][this.pos[1]] == PIT) meetPit = true;
    if (this.map.map[this.pos[0]][this.pos[1]] == GOAL) {
      meetGoal = true;
      this.carryGoal = true;
      this.map.map[this.pos[0]][this.pos[1]] = 0;
    }
    if (this._around(PIT)) meetBreeze = true;
    if (this._around(WUMPUS) ||
        this._around(WUMPUSDEAD) ||
        this._around(DEADBODY)) meetStench = true;
    this.flag.reset(
        wumpus: meetWumpus,
        wumpusDead: meetWumpusDead,
        deadBody: meetDeadBody,
        sound: meetSound,
        pit: meetPit,
        goal: meetGoal,
        breeze: meetBreeze,
        stench: meetStench,
        startMove: startToMove);
  }
}

class Wumpus extends Character {
  Player player;
  int oldEvent;

  Wumpus({List<int> pos, GameMap map, Flag flag, Player player}) {
    this.pos = pos;
    this.map = map;
    this.flag = flag;
    this.player = player;
    this.active = false;
    this.player.wumpus = this;
    this.oldEvent = 0;
  }

  List<int> move() {
    PathFinding pathFind =
        PathFinding(map: this.map, start: this.pos, end: this.player.pos);
    pathFind.solve();
    List<Node> path = pathFind.path;
    List<int> newPos = path[path.length - 2].current;
    List<int> oldPos = this.pos;
    this.pos = newPos;
    this._triggerEventOnMove();
    this.map.map[oldPos[0]][oldPos[1]] =
        (this.oldEvent == SOUND ? 0 : this.oldEvent);
    this.oldEvent = this.map.map[newPos[0]][newPos[1]];
    this.map.map[newPos[0]][newPos[1]] = WUMPUS;
    this.map.wumpusPos = newPos;
    return newPos;
  }

  void _triggerEventOnMove() {
    bool meetSound = false;
    bool activeWumpus = false;
    bool activeWumpusNear = false;

    if (this.map.map[this.pos[0]][this.pos[1]] == SOUND) meetSound = true;
    if (this.active) activeWumpus = true;
    if (this.active && manhattanDist(this.pos, this.player.pos) <= 2)
      activeWumpusNear = true;
    this.flag.reset(
        sound: meetSound,
        activeWumpus: activeWumpus,
        activeWumpusNear: activeWumpusNear);
  }
}