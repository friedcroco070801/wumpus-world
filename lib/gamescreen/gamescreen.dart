import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wumpus_world/gameengine/map.dart';
import 'package:wumpus_world/gamescreen/colorpallete.dart';
import 'package:wumpus_world/gamescreen/controller.dart';
import 'package:wumpus_world/gamescreen/game.dart';
import 'package:wumpus_world/gamescreen/mapblock.dart';
import 'package:wumpus_world/gamescreen/notifybox.dart';

final int SIZEMARGIN = 40;

class GameScreen extends StatelessWidget {
  AnimatedText animatedText;
  DirectionController directionController;
  ActionButton actionButton;
  MapBlock mapBlock;
  PlayerCell playerCell;

  GameScreen(this.animatedText, this.directionController, this.actionButton,
      this.playerCell, this.mapBlock);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (_, orientation) {
      if (orientation == Orientation.portrait)
        return _portraitGameScreen(context);
      else
        return _landscapeGameScreen(context);
    });
  }

  Widget _portraitGameScreen(BuildContext context) {
    double statusHeight = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height - statusHeight;
    double width = MediaQuery.of(context).size.width;
    double heightBox = height - width;
    double widthBox = width / 2;
    return Container(
      color: GameColor.ONYX,
      child: Column(
        children: [
          Container(
            height: statusHeight,
            color: GameColor.ONYX,
          ),
          Container(
            margin: EdgeInsets.all(width / 40),
            child: () {
              this.mapBlock.setParameters(width - width / 20);
              return this.mapBlock;
            }(),
          ),
          Row(
            children: [
              NotifyBox(
                  widthBox,
                  heightBox,
                  MediaQuery.of(context).size.width / 40,
                  animatedText,
                  'portrait'),
              Controller(
                  widthBox,
                  heightBox,
                  MediaQuery.of(context).size.width / 40,
                  'portrait',
                  directionController,
                  actionButton)
            ],
          )
        ],
      ),
    );
  }

  Widget _landscapeGameScreen(BuildContext context) {
    double statusHeight = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height - statusHeight;
    double width = MediaQuery.of(context).size.width;
    double widthBox = width - height;
    double heightBox = height / 2;
    return Container(
      color: GameColor.ONYX,
      child: Column(
        children: [
          Container(
            height: statusHeight,
            color: GameColor.ONYX,
          ),
          Row(
            children: [
              Container(
                width: height,
                height: height,
                color: Colors.black,
                child: Stack(
                  children: [
                    Container(
                      width: height,
                      height: height,
                      color: GameColor.BROWN,
                    ),
                    Container(
                      margin: EdgeInsets.all(height / SIZEMARGIN),
                      color: Colors.black,
                      child: () {
                        this
                            .mapBlock
                            .setParameters(height - height * 2 / SIZEMARGIN);
                        return this.mapBlock;
                      }(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: height / 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NotifyBox(widthBox - height / 40, heightBox, height / 40,
                      animatedText, 'landscape'),
                  Controller(widthBox - height / 40, heightBox, height / 40,
                      'landscape', directionController, actionButton)
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
