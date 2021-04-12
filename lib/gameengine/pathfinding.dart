import 'package:collection/collection.dart';
import 'package:wumpus_world/gameengine/map.dart';
import 'dart:core';

int manhattanDist(List<int> a, List<int> b) {
  return (a[0] - b[0]).abs() + (a[1] - b[1]).abs();
}

class Node {
  Node parent;

  GameMap map;
  int size;
  List<int> current;
  List<int> goal;

  int _g; // depth
  int _h;
  int _f;

  Node(
      {GameMap map,
      List<int> current,
      List<int> goal,
      int depth = 0,
      Node parent}) {
    this.map = map;
    this.size = map.size;
    this.current = current;
    this.goal = goal;
    this._g = depth;
    this._h = manhattanDist(current, goal);
    this._f = this._g + this._h;
    this.parent = parent;
  }

  @override
  bool operator ==(other) {
    return (this.current[0] == other.current[0]) &&
        (this.current[1] == other.current[1]);
  }

  @override
  int get hashCode {
    return this.current[0] * map.size + this.current[1];
  }

  static int comparator(Node a, Node b) {
    if (a._f < b._f)
      return -1;
    else if (a._f == b._f)
      return 0;
    else
      return 1;
  }

  Node move(String dir) {
    List<int> newCurrent;
    if (dir == 'u' && this.current[0] > 0) {
      newCurrent = [this.current[0] - 1, this.current[1]];
    } else if (dir == 'd' && this.current[0] < this.size - 1) {
      newCurrent = [this.current[0] + 1, this.current[1]];
    } else if (dir == 'l' && this.current[1] > 0) {
      newCurrent = [this.current[0], this.current[1] - 1];
    } else if (dir == 'r' && this.current[1] < this.size - 1) {
      newCurrent = [this.current[0], this.current[1] + 1];
    } else {
      return null;
    }
    if (this.map.isObstacle(newCurrent)) return null;
    return Node(
        map: this.map,
        current: newCurrent,
        goal: this.goal,
        depth: this._g + 1,
        parent: this);
  }

  List<Node> getChildren() {
    List<Node> res = [];
    Node temp;
    List<String> dirs = ['u', 'd', 'l', 'r'];
    for (String dir in dirs) {
      temp = this.move(dir);
      if (temp != null) res.add(temp);
    }
    return res;
  }

  bool isGoal() {
    return (this._h == 0);
  }

  List<Node> getPath() {
    List<Node> path = [];
    Node temp = this;
    while (temp != null) {
      path.add(temp);
      print(temp.current);
      temp = temp.parent;
    }
    return path;
  }
}

class PathFinding {
  GameMap map;
  List<int> start;
  List<int> end;
  List<Node> path = [];

  PathFinding({GameMap map, List<int> start, List<int> end}) {
    this.map = map;
    this.start = start;
    this.end = end;
  }

  bool solve() {
    HeapPriorityQueue<Node> queue = HeapPriorityQueue<Node>(Node.comparator);
    Set<Node> visited = Set();

    Node start = Node(
        map: this.map,
        current: this.start,
        goal: this.end,
        depth: 0,
        parent: null);

    queue.add(start);
    visited.add(start);

    while (queue.length > 0) {
      Node temp = queue.removeFirst();

      if (temp.isGoal()) {
        this.path = temp.getPath();
        for (Node point in this.path) {
          print(point.current);
        }
        return true;
      }

      List<Node> children = temp.getChildren();

      for (Node child in children) {
        if (!visited.contains(child)) {
          visited.add(child);
          queue.add(child);
        }
      }
    }

    return false;
  }
}
