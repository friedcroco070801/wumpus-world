import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wumpus_world/customwidget.dart';
import 'package:wumpus_world/data/gamedata.dart';
import 'package:wumpus_world/gamescreen/colorpallete.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:wumpus_world/gamescreen/game.dart';
import 'package:wumpus_world/mainscreen/tutorial.dart';

class MainScreen extends StatelessWidget {
  double textHeight;
  double menuHeight;
  double menuWidth;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    textHeight = (MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top) *
        1 /
        3;
    menuHeight = (MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top) *
        2 /
        3;
    menuWidth = MediaQuery.of(context).size.width / 2;
    return Container(
      color: GameColor.ONYX,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Container(
            height: textHeight * 9 / 10,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Material(
              type: MaterialType.transparency,
              child: Text(
                'WumpuS WorlD',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: GameColor.RED,
                    fontSize: MediaQuery.of(context).size.width / 9,
                    fontFamily: 'RainyHearts'),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // SizedBox(
          //   height: textHeight * 1 / 10,
          // ),
          Container(
            height: textHeight * 1 / 10,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Material(
              type: MaterialType.transparency,
              child: Text(
                'created by friedcroco070801',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width / 48,
                    fontFamily: 'RainyHearts'),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Row(
            children: [
              Container(
                width: menuWidth * 4 / 3,
                height: menuHeight,
                alignment: Alignment.center,
                child: CustomStatefulBuilder(
                  dispose: () {},
                  builder: (context, StateSetter setState) => Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        color: GameColor.GRAY,
                        child: InkWell(
                          splashColor: Colors.black,
                          onTap: () {
                            List<int> para = GameData.levelData[
                                GameData.level >= GameData.levelData.length
                                    ? GameData.levelData.length - 1
                                    : GameData.level - 1];
                            Game game = Game(
                                para[0], para[1], para[2], para[3], context);
                            GameData.levelBar = setState;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => game.gameScreen),
                            );
                            if (GameData.tutorialData(GameData.level).length >
                                    0 &&
                                GameData.level == GameData.maxLevel)
                              Tutorial(context)
                                  .showTutorialDialog(GameData.level);
                          },
                          child: Container(
                            width: menuWidth / 3,
                            height: menuHeight / 4,
                            //color: GameColor.GRAY,
                            alignment: Alignment.center,
                            child: Material(
                              type: MaterialType.transparency,
                              child: Text(
                                'Dive into',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: menuWidth / 20,
                                    fontFamily: 'RainyHearts'),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: menuWidth / 20,
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: Text(
                          'at Level',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: menuWidth / 20,
                              fontFamily: 'RainyHearts'),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        width: menuWidth / 20,
                      ),
                      Container(
                        width: menuWidth / 6,
                        child: Material(
                          color: GameColor.GRAY,
                          type: MaterialType.card,
                          child: SpinBox(
                            direction: Axis.vertical,
                            min: 1,
                            max: GameData.maxLevel.toDouble(),
                            value: () {
                              return GameData.level.toDouble();
                            }(),
                            onChanged: (value) {
                              GameData.level = value.toInt();
                              setState(() {});
                            },
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: menuWidth / 20,
                                fontFamily: 'RainyHearts'),
                          ),
                        ),
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: Text(
                          ' / ${GameData.maxLevel}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: menuWidth / 20,
                              fontFamily: 'RainyHearts'),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: menuWidth * 2 / 3,
                height: menuHeight,
                alignment: Alignment.center,
                child: Container(
                  width: menuWidth * 2 / 3,
                  height: menuHeight * 4 / 5,
                  child: Image.asset(
                    'assets/images/WumpusBlack.png',
                    fit: BoxFit.contain,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
