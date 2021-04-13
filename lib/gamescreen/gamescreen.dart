import 'package:flutter/material.dart';
import 'package:wumpus_world/gamescreen/colorpallete.dart';

class GameScreen extends StatelessWidget {
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
    return Column(
      children: [
        Container(
          height: statusHeight,
          color: GameColor.ONYX,
        ),
        Container(
          height: width,
          width: width,
          color: GameColor.RED,
        ),
        Row(
          children: [
            Container(
              height: heightBox,
              width: widthBox,
              color: GameColor.BLUE,
            ),
            Container(
              height: heightBox,
              width: widthBox,
              color: GameColor.TEAL,
            ),
          ],
        )
      ],
    );
  }

  Widget _landscapeGameScreen(BuildContext context) {
    double statusHeight = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height - statusHeight;
    double width = MediaQuery.of(context).size.width;
    double widthBox = width - height;
    double heightBox = height / 2;
    return Column(
      children: [
        Container(
          height: statusHeight,
          color: GameColor.ONYX,
        ),
        Row(
          children: [
            Container(
              height: height,
              width: height,
              color: GameColor.RED,
            ),
            Column(
              children: [
                Container(
                  height: heightBox,
                  width: widthBox,
                  color: GameColor.BLUE,
                ),
                Container(
                  height: heightBox,
                  width: widthBox,
                  color: GameColor.TEAL,
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}
