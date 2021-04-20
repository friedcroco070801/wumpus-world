import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wumpus_world/gamescreen/colorpallete.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

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
            height: textHeight,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Material(
              type: MaterialType.transparency,
              child: Text(
                'WumpuS WorlD',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: GameColor.RED,
                    fontSize: MediaQuery.of(context).size.width / 8,
                    fontFamily: 'RainyHearts'),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Row(
            children: [
              Container(
                width: menuWidth,
                height: menuHeight,
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      color: GameColor.GRAY,
                      child: InkWell(
                        splashColor: Colors.black,
                        onTap: () {},
                        child: Container(
                          width: menuWidth / 3,
                          height: menuHeight / 4,
                          //color: GameColor.GRAY,
                          alignment: Alignment.center,
                          child: Material(
                            type: MaterialType.transparency,
                            child: Text(
                              'DivE IntO',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
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
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: menuWidth / 20,
                            fontFamily: 'RainyHearts'),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: menuWidth / 20,
                    )
                  ],
                ),
              ),
              Container(
                width: menuWidth,
                height: menuHeight,
                alignment: Alignment.center,
                child: Container(
                  width: menuWidth * 4 / 5,
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
