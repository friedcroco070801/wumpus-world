import 'package:flutter/material.dart';
import 'package:wumpus_world/data/gamedata.dart';
import 'package:wumpus_world/gamescreen/colorpallete.dart';

class Tutorial {
  BuildContext context;

  Tutorial(this.context);

  void showTutorialDialog(int level) {
    Widget cancelButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      backgroundColor: GameColor.ONYX,
      title: Text(
        'Warning - Incoming Wumpus',
        style: TextStyle(color: Colors.white, fontFamily: 'RainyHearts'),
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 1 / 2,
          child: Column(
            children: () {
              List<List<String>> temp = GameData.tutorialData(level);
              List<Widget> res = [];
              for (int index = 0; index < temp.length; index++) {
                res.add(Row(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 5 / 32,
                        height: MediaQuery.of(context).size.width * 5 / 32,
                        child: Image.asset(
                          temp[index][0],
                          fit: BoxFit.contain,
                        )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 1 / 32,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 10 / 32,
                      child: Text(
                        temp[index][1],
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'RainyHearts'),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ));
                res.add(SizedBox(
                  height: MediaQuery.of(context).size.width * 1 / 32,
                ));
              }
              res.add(Text(
                'Beware! The Wumpus is coming!',
                style:
                    TextStyle(color: Colors.white, fontFamily: 'RainyHearts'),
                textAlign: TextAlign.center,
              ));
              return res;
            }(),
          ),
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
}
