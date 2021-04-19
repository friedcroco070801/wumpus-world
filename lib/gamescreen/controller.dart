import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wumpus_world/customwidget.dart';
import 'package:wumpus_world/gameengine/characters.dart';
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

  DirectionController directionController;
  ActionButton actionButton;

  Controller(this.width, this.height, this.margin, this.orientation,
      this.directionController, this.actionButton) {
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
            child: () {
              actionButton.setParameters(directionHeight, actionHeight, margin);
              return actionButton;
            }(),
          ),
          Container(
            width: directionHeight,
            height: directionHeight,
            margin: EdgeInsets.fromLTRB(
                this.margin / 2, 0.0, this.margin, this.margin),
            child: () {
              directionController.setParameters(
                  directionHeight, directionHeight, this.margin);
              return directionController;
            }(),
          )
        ],
      );
    } else
      return Row(
        children: [
          Container(
            height: directionWidthLand,
            width: actionWidthLand,
            margin: EdgeInsets.fromLTRB(0.0, this.margin / 2, 0.0, this.margin),
            child: () {
              actionButton.setParameters(
                  actionWidthLand, directionWidthLand, margin);
              return actionButton;
            }(),
          ),
          Container(
            width: directionWidthLand,
            height: directionWidthLand,
            margin: EdgeInsets.fromLTRB(
                this.margin, this.margin / 2, this.margin, this.margin),
            child: () {
              directionController.setParameters(
                  directionWidthLand, directionWidthLand, this.margin);
              return directionController;
            }(),
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
  void Function(String) move;
  Player player;

  DirectionController(
      this.width, this.height, this.margin, this.move, this.player) {
    this.boxSize = (this.width - 2 * this.margin) / 3;
  }

  void setParameters(double width, double height, double margin) {
    this.width = width;
    this.height = height;
    this.margin = margin;
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
                SizedBox(
                  width: boxSize + margin,
                  height: boxSize,
                ),
                player.canMove('u') && player.active
                    ? GestureDetector(
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
                          move('u');
                        },
                      )
                    : SizedBox(
                        width: boxSize,
                      ),
                SizedBox(width: boxSize + margin),
              ],
            ),
            SizedBox(
              height: this.margin,
            ),
            Row(
              children: [
                player.canMove('l') && player.active
                    ? GestureDetector(
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
                          move('l');
                        },
                      )
                    : Container(
                        width: boxSize,
                      ),
                SizedBox(
                  width: this.margin,
                  height: boxSize,
                ),
                MapCell(
                  boxSize,
                  player.map,
                  player.pos[0],
                  player.pos[1],
                  player.wumpus,
                  mode: 'Show',
                ),
                SizedBox(
                  width: this.margin,
                ),
                player.canMove('r') && player.active
                    ? GestureDetector(
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
                          move('r');
                        },
                      )
                    : SizedBox(
                        width: boxSize,
                      ),
              ],
            ),
            SizedBox(
              height: this.margin,
            ),
            Row(
              children: [
                SizedBox(
                  width: boxSize + margin,
                  height: boxSize,
                ),
                player.canMove('d') && player.active
                    ? GestureDetector(
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
                          move('d');
                        },
                      )
                    : SizedBox(
                        width: boxSize,
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
  Player player;
  void Function(String) arrowMove;

  void showReturnDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        //Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      backgroundColor: GameColor.ONYX,
      title: Text(
        'Do you really want to quit?',
        style: TextStyle(color: Colors.white, fontFamily: 'RainyHearts'),
        textAlign: TextAlign.center,
      ),
      content: Text(
        'All the changed cannot be saved until the end of the level. Quit anyway?',
        style: TextStyle(color: Colors.white, fontFamily: 'RainyHearts'),
        textAlign: TextAlign.center,
      ),
      actions: [okButton, cancelButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  String showArrowDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      backgroundColor: GameColor.ONYX,
      title: Text(
        'Choose the direction to shoot the arrow.',
        style: TextStyle(color: Colors.white, fontFamily: 'RainyHearts'),
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DirectionController(height, height, height / 21, (String dir) {
              Navigator.of(context).pop();
              arrowMove(dir);
            }, player),
          ],
        ),
      ),
      actions: [cancelButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  ActionButton(
      this.width, this.height, this.margin, this.arrowMove, this.player) {
    if (width > height) {
      buttonSize =
          min(min((width - margin) / 2, height), (width - 2 * margin) / 3);
    } else {
      buttonSize =
          min(min((height - margin) / 2, width), (height - 2 * margin) / 3);
    }
  }

  void setParameters(double width, double height, double margin) {
    this.width = width;
    this.height = height;
    this.margin = margin;
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
      onTap: () {
        showReturnDialog(context);
      },
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
      onTap: () {
        showArrowDialog(context);
      },
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
                player.active && player.arrow
                    ? arrowButton
                    : SizedBox(width: buttonSize, height: buttonSize)
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
                player.active && player.arrow
                    ? arrowButton
                    : SizedBox(width: buttonSize, height: buttonSize)
              ],
            );
        },
        dispose: () {});
  }
}
