import 'package:flutter/material.dart';
import 'package:wumpus_world/gameengine/map.dart';
import 'package:wumpus_world/gamescreen/colorpallete.dart';
import 'package:wumpus_world/gamescreen/controller.dart';
import 'package:wumpus_world/gamescreen/mapblock.dart';
import 'package:wumpus_world/gamescreen/notifybox.dart';

class GameScreen extends StatelessWidget {
  AnimatedText testText = AnimatedText();

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
            child: MapBlock(
                width - width / 20, GameMap.randommap(size: 8, numOfPits: 10)),
          ),
          Row(
            children: [
              NotifyBox(widthBox, heightBox,
                  MediaQuery.of(context).size.width / 40, testText, 'portrait'),
              Controller(widthBox, heightBox,
                  MediaQuery.of(context).size.width / 40, 'portrait')
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
                margin: EdgeInsets.all(height / 40),
                child: MapBlock(height - height / 20,
                    GameMap.randommap(size: 8, numOfPits: 10)),
              ),
              Column(
                children: [
                  NotifyBox(
                      widthBox, heightBox, height / 40, testText, 'landscape'),
                  Controller(widthBox, heightBox, height / 40, 'landscape')
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
