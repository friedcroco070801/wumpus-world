import 'package:flutter/material.dart';
import 'package:wumpus_world/customwidget.dart';
import 'package:wumpus_world/gamescreen/colorpallete.dart';

void showWinDialog(BuildContext context) {
  Widget cancelButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    backgroundColor: GameColor.ONYX,
    title: Text(
      'Congratulations!',
      style: TextStyle(color: Colors.white, fontFamily: 'RainyHearts'),
      textAlign: TextAlign.center,
    ),
    content: Text(
      'You have brought back the treasure safely!',
      style: TextStyle(color: Colors.white, fontFamily: 'RainyHearts'),
      textAlign: TextAlign.center,
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

void showLosePitDialog(BuildContext context) {
  Widget cancelButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    backgroundColor: GameColor.RED,
    title: Text(
      'You fell into the infinite pit!',
      style: TextStyle(color: Colors.white, fontFamily: 'RainyHearts'),
      textAlign: TextAlign.center,
    ),
    content: Text(
      'Better luck next time, adventurer. Maybe?',
      style: TextStyle(color: Colors.white, fontFamily: 'RainyHearts'),
      textAlign: TextAlign.center,
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

Future<void> showLoseWumpusDialog(BuildContext context) async {
  Widget cancelButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    backgroundColor: GameColor.RED,
    title: Text(
      'You\'ve been eaten!',
      style: TextStyle(color: Colors.white, fontFamily: 'RainyHearts'),
      textAlign: TextAlign.center,
    ),
    content: Text(
      'Better luck next time, adventurer. Maybe?',
      style: TextStyle(color: Colors.white, fontFamily: 'RainyHearts'),
      textAlign: TextAlign.center,
    ),
    actions: [cancelButton],
  );

  void Function(void Function()) update;
  String wumImage = 'assets/images/WumpusLose0.png';
  bool showImage = true;
  CustomStatefulBuilder imageWum = CustomStatefulBuilder(
      builder: (context, StateSetter setState) {
        update = setState;
        return Container(
          width: MediaQuery.of(context).size.width * 3 / 4,
          height: MediaQuery.of(context).size.height * 3 / 4,
          color: showImage ? Colors.black : GameColor.RED,
          alignment: Alignment.center,
          child: showImage
              ? Container(
                  width: MediaQuery.of(context).size.height * 9 / 16,
                  height: MediaQuery.of(context).size.height * 9 / 16,
                  child: Image.asset(
                    wumImage,
                    fit: BoxFit.contain,
                  ),
                )
              : Container(),
        );
      },
      dispose: () {});

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(
        child: imageWum,
        onWillPop: () async => false,
      );
    },
  );

  await Future.delayed(Duration(seconds: 2));
  wumImage = 'assets/images/WumpusLose1.png';
  update(() {});

  await Future.delayed(Duration(milliseconds: 500));
  showImage = false;
  update(() {});

  await Future.delayed(Duration(seconds: 1));
  Navigator.of(context).pop();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
