import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wumpus_world/customwidget.dart';
import 'package:wumpus_world/gamescreen/colorpallete.dart';
import 'package:wumpus_world/gamescreen/mapblock.dart';

class Controller extends StatelessWidget {
  double width;
  double height;
  double margin;
  String orientation;

  double directionHeight;
  double actionHeight;

  double directionWidthLand;
  double actionWidthLand;

  Controller(this.width, this.height, this.margin, this.orientation) {
    directionHeight = this.width - 1.5 * this.margin;
    actionHeight = this.height - directionHeight - 2 * this.margin;

    directionWidthLand = this.height - 1.5 * this.margin;
    actionWidthLand = this.width - directionWidthLand - 2 * this.margin;
  }

  @override
  Widget build(BuildContext context) {
    if (this.width < this.height) {
      return Column(
        children: [
          Container(
            height: actionHeight,
            width: directionHeight,
            margin: EdgeInsets.fromLTRB(
                this.margin / 2, 0.0, this.margin, this.margin),
            child: ActionButton(directionHeight, actionHeight, margin),
          ),
          Container(
              width: directionHeight,
              height: directionHeight,
              margin: EdgeInsets.fromLTRB(
                  this.margin / 2, 0.0, this.margin, this.margin),
              child: DirectionController(
                  directionHeight, directionHeight, this.margin)),
        ],
      );
    } else
      return Row(
        children: [
          Container(
            height: directionWidthLand,
            width: actionWidthLand,
            margin: EdgeInsets.fromLTRB(0.0, this.margin / 2, 0.0, this.margin),
            child: ActionButton(actionWidthLand, directionWidthLand, margin),
          ),
          Container(
            width: directionWidthLand,
            height: directionWidthLand,
            margin: EdgeInsets.fromLTRB(
                this.margin, this.margin / 2, this.margin, this.margin),
            child: DirectionController(
                directionWidthLand, directionWidthLand, this.margin),
          )
        ],
      );
  }
}

class DirectionController extends StatelessWidget {
  double width;
  double height;
  double margin;
  double boxSize;
  void Function(void Function()) update;

  DirectionController(this.width, this.height, this.margin) {
    this.boxSize = (this.width - 2 * this.margin) / 3;
  }

  @override
  Widget build(BuildContext context) {
    return CustomStatefulBuilder(
      builder: (context, StateSetter setState) {
        this.update = setState;
        return Column(
          children: [
            Row(
              children: [
                SizedBox(width: boxSize + margin),
                GestureDetector(
                  child: Container(
                    width: boxSize,
                    height: boxSize,
                    color: Colors.black,
                    child: Icon(
                      Icons.arrow_drop_up,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    MapBlock.player.move(dir: 'u');
                  },
                ),
                SizedBox(width: boxSize + margin),
              ],
            ),
            SizedBox(
              height: this.margin,
            ),
            Row(
              children: [
                GestureDetector(
                  child: Container(
                    width: boxSize,
                    height: boxSize,
                    color: Colors.black,
                    child: Icon(
                      Icons.arrow_left,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    MapBlock.player.move(dir: 'l');
                  },
                ),
                SizedBox(
                  width: this.margin,
                ),
                GestureDetector(
                  child: Container(
                    width: boxSize,
                    height: boxSize,
                    color: Colors.black,
                    child: Icon(
                      Icons.remove_red_eye_outlined,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {},
                ),
                SizedBox(
                  width: this.margin,
                ),
                GestureDetector(
                  child: Container(
                    width: boxSize,
                    height: boxSize,
                    color: Colors.black,
                    child: Icon(
                      Icons.arrow_right,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    MapBlock.player.move(dir: 'r');
                  },
                ),
              ],
            ),
            SizedBox(
              height: this.margin,
            ),
            Row(
              children: [
                SizedBox(width: boxSize + margin),
                GestureDetector(
                  child: Container(
                    width: boxSize,
                    height: boxSize,
                    color: Colors.black,
                    child: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    MapBlock.player.vanish();
                  },
                ),
                SizedBox(width: boxSize + margin),
              ],
            ),
          ],
        );
      },
      dispose: () {},
    );
  }
}

class ActionButton extends StatelessWidget {
  double width;
  double height;
  double margin;
  double buttonSize;
  void Function(void Function()) update;

  ActionButton(this.width, this.height, this.margin) {
    if (width > height) {
      buttonSize =
          min(min((width - margin) / 2, height), (width - 2 * margin) / 3);
    } else {
      buttonSize =
          min(min((height - margin) / 2, width), (height - 2 * margin) / 3);
    }
  }

  @override
  Widget build(BuildContext context) {
    GestureDetector backButton = GestureDetector(
      onTap: () {},
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
        child: Icon(
          Icons.keyboard_return,
          color: Colors.white,
        ),
      ),
    );
    GestureDetector arrowButton = GestureDetector(
      onTap: () {},
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
        child: Icon(
          Icons.location_searching_outlined,
          color: Colors.white,
        ),
      ),
    );
    return CustomStatefulBuilder(
        builder: (context, StateSetter setState) {
          this.update = setState;
          if (width > height)
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                backButton,
                SizedBox(
                  width: this.margin,
                ),
                arrowButton
              ],
            );
          else
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                backButton,
                SizedBox(
                  height: this.margin,
                ),
                arrowButton
              ],
            );
        },
        dispose: () {});
  }
}
