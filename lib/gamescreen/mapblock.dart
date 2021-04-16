import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wumpus_world/customwidget.dart';
import 'package:wumpus_world/gameengine/map.dart';
import 'package:wumpus_world/gamescreen/colorpallete.dart';

class MapBlock extends StatelessWidget {
  double width, margin, widthCell;
  int size;
  GameMap map;
  void Function(void Function()) update;
  static PlayerCell player;

  MapBlock(this.width, this.map) {
    this.size = map.size;
    this.margin = (width / 7) / size;
    this.widthCell = (width - margin * (size - 1)) / size;
  }

  @override
  Widget build(BuildContext context) {
    if (player == null) player = PlayerCell(size, 7, 7);
    return CustomStatefulBuilder(
      builder: (context, StateSetter setState) {
        this.update = setState;
        return Stack(
          children: [
            Container(
              width: width,
              height: width,
              child: () {
                int i, j;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (i = 0; i < size; i++)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (j = 0; j < size; j++)
                            MapCell(widthCell, map, i, j)
                        ],
                      )
                  ],
                );
              }(),
            ),
            player
          ],
        );
      },
      dispose: () {},
    );
  }
}

class MapCell extends StatelessWidget {
  double width;
  double imageWidth;
  GameMap map;
  int row, col;

  MapCell(this.width, this.map, this.row, this.col) {
    this.imageWidth = 3 / 4 * width;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stackChildren = [];
    double curWidth = width;
    for (String item in this.map.visitedMap[row][col]) {
      if (item == 'Breeze') {
        stackChildren.add(Container(
          width: curWidth,
          height: curWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width / 6),
            color: GameColor.GREEN,
          ),
        ));
        curWidth -= width / 6;
        stackChildren.add(Container(
          width: curWidth,
          height: curWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width / 6),
            color: Colors.black,
          ),
        ));
        curWidth -= width / 6;
      }
      if (item == 'Stench') {
        stackChildren.add(Container(
          width: curWidth,
          height: curWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width / 6),
            color: GameColor.VIOLET,
          ),
        ));
        curWidth -= width / 6;
        stackChildren.add(Container(
          width: curWidth,
          height: curWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width / 6),
            color: Colors.black,
          ),
        ));
        curWidth -= width / 6;
      }
      if (item == 'Empty') {
        stackChildren.add(Container(
          width: curWidth,
          height: curWidth,
          color: Colors.black,
        ));
        curWidth -= width / 6;
      }
      if (item == 'Wumpus' ||
          item == 'Pit' ||
          item == 'DeadBody' ||
          item == 'WumpusDead' ||
          item == 'Goal') {
        stackChildren.add(Container(
          width: imageWidth,
          height: imageWidth,
          child: Image.asset(
            'assets/images/' + item + '.png',
            fit: BoxFit.contain,
          ),
        ));
      }
    }
    return Stack(
      alignment: Alignment.center,
      children: stackChildren,
    );
  }
}

class PlayerCell extends StatelessWidget {
  double left, up, leftBase, upBase;
  int row, col, size;
  double widthCell, margin;
  double widthBox;
  void Function(void Function()) update;
  Timer timer;
  bool moving;

  PlayerCell(this.size, this.row, this.col) {
    this.moving = false;
  }

  @override
  Widget build(BuildContext context) {
    if (!this.moving) {
      if (MediaQuery.of(context).size.width <
          MediaQuery.of(context).size.height) {
        this.widthBox = MediaQuery.of(context).size.width * (1 - 1 / 20);
      } else {
        this.widthBox = (MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top) *
            (1 - 1 / 20);
      }

      this.margin = (widthBox / 7) / size;
      this.widthCell = (widthBox - this.margin * (size - 1)) / size;
      double horizonalCen =
          this.widthCell / 2 + col * (this.widthCell + this.margin);
      double verticalCen =
          this.widthCell / 2 + row * (this.widthCell + this.margin);
      this.left = horizonalCen - widthCell * 3 / 8;
      this.up = verticalCen - widthCell * 3 / 8;
    }

    return CustomStatefulBuilder(builder: (context, StateSetter setState) {
      this.update = setState;
      return Positioned(
          left: left,
          width: widthCell * 3 / 4,
          top: up,
          height: widthCell * 3 / 4,
          child: Container(
            width: widthCell * 3 / 4,
            height: widthCell * 3 / 4,
            child: Image.asset(
              'assets/images/Player.png',
              fit: BoxFit.contain,
            ),
          ));
    }, dispose: () {
      this.timer?.cancel();
      this.moving = false;
    });
  }

  void move({String dir, int speed = 10}) {
    this.moving = true;
    this.upBase = this.up;
    this.leftBase = this.left;
    if (dir == 'u') {
      this.row -= 1;
    } else if (dir == 'd') {
      this.row += 1;
    } else if (dir == 'l') {
      this.col -= 1;
    } else if (dir == 'r') {
      this.col += 1;
    }
    double horizonalCen =
        this.widthCell / 2 + col * (this.widthCell + this.margin);
    double verticalCen =
        this.widthCell / 2 + row * (this.widthCell + this.margin);
    this.leftBase = horizonalCen - widthCell * 3 / 8;
    this.upBase = verticalCen - widthCell * 3 / 8;
    double speedup = (upBase - up) / 20;
    double speedleft = (leftBase - left) / 20;
    this.timer = Timer.periodic(Duration(milliseconds: speed), (timer) {
      if (this.left != this.leftBase) this.left += speedleft;
      if (this.up != this.upBase) this.up += speedup;
      this.update(() {});
      if ((this.left <= this.leftBase && dir == 'l') ||
          (this.left >= this.leftBase && dir == 'r') ||
          (this.up >= this.upBase && dir == 'd') ||
          (this.up <= this.upBase && dir == 'u')) timer.cancel();
    });
    this.moving = false;
  }
}
