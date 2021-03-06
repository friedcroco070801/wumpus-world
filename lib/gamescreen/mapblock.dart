import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wumpus_world/customwidget.dart';
import 'package:wumpus_world/gameengine/characters.dart';
import 'package:wumpus_world/gameengine/map.dart';
import 'package:wumpus_world/gamescreen/colorpallete.dart';

class MapBlock extends StatelessWidget {
  double width, margin, widthCell;
  int size;
  GameMap map;
  void Function(void Function()) update;
  PlayerCell player;
  Wumpus wumpus;

  MapBlock(this.width, this.map, this.player, this.wumpus) {
    this.size = map.size;
    this.margin = (width / 7) / size;
    this.widthCell = (width - margin * (size - 1)) / size;
  }

  void setParameters(double width) {
    this.width = width;
    this.size = map.size;
    this.margin = (width / 7) / size;
    this.widthCell = (width - margin * (size - 1)) / size;
  }

  @override
  Widget build(BuildContext context) {
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
                            MapCell(widthCell, map, i, j, wumpus)
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
  Wumpus wumpus;
  Player player;
  String mode;

  MapCell(this.width, this.map, this.row, this.col, this.wumpus,
      {String mode = 'None'}) {
    this.player = wumpus.player;
    this.imageWidth = 3 / 4 * width;
    this.mode = mode;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stackChildren = [];
    double curWidth = width;
    stackChildren.add(Container(
      width: curWidth,
      height: curWidth,
      color: Colors.black,
    ));

    for (String item in this.map.visitedMap[row][col]) {
      if (item == 'Breeze' && !player.win && !player.lose) {
        stackChildren.add(Container(
          width: curWidth,
          height: curWidth,
          decoration: BoxDecoration(
            //borderRadius: BorderRadius.circular(width / 6),
            shape: BoxShape.circle,
            color: GameColor.GREEN,
          ),
        ));
        curWidth -= width / 6;
        stackChildren.add(Container(
          width: curWidth,
          height: curWidth,
          decoration: BoxDecoration(
            //borderRadius: BorderRadius.circular(width / 6),
            shape: BoxShape.circle,
            color: Colors.black,
          ),
        ));
        curWidth -= width / 6;
      }
      if (item == 'Stench' &&
          (!wumpus.active || mode == 'Show') &&
          !player.win &&
          !player.lose) {
        stackChildren.add(Container(
          width: curWidth,
          height: curWidth,
          decoration: BoxDecoration(
            //borderRadius: BorderRadius.circular(width / 6),
            shape: BoxShape.circle,
            color: GameColor.VIOLET,
          ),
        ));
        curWidth -= width / 6;
        stackChildren.add(Container(
          width: curWidth,
          height: curWidth,
          decoration: BoxDecoration(
            //borderRadius: BorderRadius.circular(width / 6),
            shape: BoxShape.circle,
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

      if (row == 0 && col == 0)
        stackChildren.add(Container(
          width: imageWidth,
          height: imageWidth,
          child: Image.asset(
            'assets/images/Door.png',
            fit: BoxFit.contain,
          ),
        ));

      if (item == 'Wumpus' ||
          item == 'Pit' ||
          item == 'DeadBody' ||
          item == 'WumpusDead' ||
          ((item == 'Goal' || item == 'Sound') &&
              (mode == 'Show' || player.win || player.lose))) {
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
      children: (mode != 'NotShow')
          ? stackChildren
          : [
              SizedBox(
                width: width,
              )
            ],
    );
  }
}

class PlayerCell extends StatelessWidget {
  double left, up, leftBase, upBase;
  int row, col, size;
  double widthCell, margin;
  double widthBox;
  void Function(void Function(), {String image}) update;
  Timer timer;
  bool moving;
  bool vanished;
  double angle;
  String image;

  PlayerCell(this.size, this.row, this.col) {
    this.moving = false;
    this.vanished = false;
    this.angle = 0;
    this.image = 'assets/images/Player.png';
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
      this.update = (void Function() setWut,
          {String image = 'assets/images/Player.png'}) {
        this.image = image;
        setState(setWut);
      };
      return (this.vanished)
          ? Container()
          : Positioned(
              left: left,
              width: widthCell * 3 / 4,
              top: up,
              height: widthCell * 3 / 4,
              child: Container(
                width: widthCell * 3 / 4,
                height: widthCell * 3 / 4,
                child: Transform.rotate(
                  alignment: Alignment.center,
                  angle: this.angle,
                  child: Image.asset(
                    image,
                    fit: BoxFit.contain,
                  ),
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
    int count = 0;

    this.timer = Timer.periodic(Duration(milliseconds: speed), (timer) {
      this.timer = timer;
      if (this.left != this.leftBase) this.left += speedleft;
      if (this.up != this.upBase) this.up += speedup;
      this.update(() {}, image: () {
        int temp = count ~/ 5;
        String tempString = ((temp > 3) ? '3' : temp.toString());
        return ('assets/images/Player' + dir + tempString + '.png');
      }());
      count += 1;
      if ((this.left <= this.leftBase && dir == 'l') ||
          (this.left >= this.leftBase && dir == 'r') ||
          (this.up >= this.upBase && dir == 'd') ||
          (this.up <= this.upBase && dir == 'u')) {
        timer.cancel();
        this.update(() {});
        this.moving = false;
      }
    });
  }

  void vanish({int speed = 40}) {
    this.moving = true;

    double vanishSpeed = widthCell * 3 / 8 / 10;
    double vanishSizeSpeed = widthCell / 10;

    this.timer = Timer.periodic(Duration(milliseconds: speed), (timer) {
      this.timer = timer;
      this.left += vanishSpeed;
      this.up += vanishSpeed;
      if (widthCell - vanishSizeSpeed > 0) this.widthCell -= vanishSizeSpeed;
      this.angle += pi / 2;
      this.update(() {});
      if (widthCell - vanishSizeSpeed <= 0) {
        timer.cancel();
        this.vanished = true;
      }
    });

    this.moving = false;
  }

  void shootArrow({String dir}) {
    this.update(() {}, image: ('assets/images/PlayerArrow' + dir + '0.png'));
    Timer(Duration(milliseconds: 500), () {
      this.update(() {}, image: ('assets/images/PlayerArrow' + dir + '1.png'));
      Timer(Duration(milliseconds: 500), () {
        this.update(() {},
            image: ('assets/images/PlayerArrow' + dir + '2.png'));
        Timer(Duration(milliseconds: 1000), () {
          this.update(() {},
              image: ('assets/images/PlayerArrow' + dir + '3.png'));
          Timer(Duration(milliseconds: 1000), () {
            this.update(() {}, image: ('assets/images/Player.png'));
          });
        });
      });
    });

    //this.update(() {});
  }
}
