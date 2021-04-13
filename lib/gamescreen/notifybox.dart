import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wumpus_world/gamescreen/colorpallete.dart';

class NotifyBox extends StatelessWidget {
  double width;
  double height;
  double margin;
  Widget animatedText;

  NotifyBox(this.width, this.height, this.margin, this.animatedText);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: this.width - 2 * this.margin,
      height: this.height - 2 * this.margin,
      margin: EdgeInsets.all(this.margin),
      padding: EdgeInsets.all(this.margin),
      color: Colors.black,
      child: this.animatedText,
    );
  }
}

class AnimatedText extends StatelessWidget {
  String text = 'Alehap';
  void Function(void Function()) update;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, StateSetter setState) {
      this.update = setState;
      return Material(
        type: MaterialType.transparency,
        child: Text(
          this.text,
          style: TextStyle(
              color: Colors.white, fontSize: 12.0, fontFamily: 'YumenoMori'),
          textAlign: TextAlign.center,
        ),
      );
    });
  }

  void animateUntil({String fulltext, int milliseconds = 20}) {
    this.text = '';
    this.update(() {});
    Timer.periodic(Duration(milliseconds: milliseconds), (timer) {
      if (this.text.length >= fulltext.length) {
        timer.cancel();
        return;
      }
      // print(this.text.length);
      this.text = this.text + fulltext[this.text.length];
      this.update(() {});
    });
  }
}
