import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wumpus_world/customwidget.dart';
import 'package:wumpus_world/gamescreen/colorpallete.dart';

class NotifyBox extends StatelessWidget {
  double width;
  double height;
  double margin;
  Widget animatedText;
  String orientation;

  NotifyBox(this.width, this.height, this.margin, this.animatedText,
      this.orientation);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width:
          this.width - (this.orientation == 'portrait' ? 1.5 : 1) * this.margin,
      height: this.height -
          (this.orientation == 'portrait' ? 1 : 1.5) * this.margin,
      margin: this.orientation == 'portrait'
          ? EdgeInsets.fromLTRB(this.margin, 0.0, this.margin / 2, this.margin)
          : EdgeInsets.fromLTRB(0.0, this.margin, this.margin, this.margin / 2),
      padding: EdgeInsets.all(this.margin),
      color: Colors.black,
      child: this.animatedText,
    );
  }
}

class AnimatedText extends StatelessWidget {
  String text;
  String baseText;
  void Function(void Function()) update;
  Timer timer;

  @override
  Widget build(BuildContext context) {
    if (this.baseText != null)
      this.text = this.baseText;
    else
      this.text = '';
    return CustomStatefulBuilder(
      builder: (context, StateSetter setState) {
        this.update = setState;
        return Material(
          type: MaterialType.transparency,
          child: Text(
            'Some rocks are falling from the ceiling. The loud sound resounds.\nA gentle breeze...\nIt smells so bad.',
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.height >
                        MediaQuery.of(context).size.width
                    ? MediaQuery.of(context).size.height / 35
                    : MediaQuery.of(context).size.width / 35,
                fontFamily: 'RainyHearts'),
            textAlign: TextAlign.center,
          ),
        );
      },
      dispose: () {
        this.timer?.cancel();
      },
    );
  }

  void animateUntil({String fulltext, int milliseconds = 20}) {
    this.text = '';
    this.baseText = fulltext;
    this.update(() {});
    this.timer = Timer.periodic(Duration(milliseconds: milliseconds), (timer) {
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
