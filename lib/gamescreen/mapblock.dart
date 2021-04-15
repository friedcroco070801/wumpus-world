import 'package:flutter/material.dart';
import 'package:wumpus_world/customwidget.dart';
import 'package:wumpus_world/gameengine/map.dart';
import 'package:wumpus_world/gamescreen/colorpallete.dart';

class MapBlock extends StatelessWidget {
  double width, margin, widthCell;
  int size;
  GameMap map;
  void Function(void Function()) update;

  MapBlock(this.width, this.map) {
    this.size = map.size;
    this.margin = (width / 7) / size;
    this.widthCell = (width - margin * (size - 1)) / size;
  }

  @override
  Widget build(BuildContext context) {
    return CustomStatefulBuilder(
      builder: (context, StateSetter setState) {
        this.update = setState;
        return Container(
          width: width,
          height: width,
          child: () {
            int i, j;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (i = 0; i < size; i++)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (j = 0; j < size; j++) MapCell(widthCell, map, i, j)
                    ],
                  )
              ],
            );
          }(),
        );
      },
      dispose: () {},
    );
  }
}

class MapCell extends StatelessWidget {
  double width;
  GameMap map;
  int row, col;

  MapCell(this.width, this.map, this.row, this.col);

  @override
  Widget build(BuildContext context) {
    List<Widget> stackChildren = [];
    double curWidth = width;
    for (String item in this.map.visitedMap[row][col]) {
      if (item == 'Breeze') {
        stackChildren.add(Container(
          width: curWidth,
          height: curWidth,
          color: GameColor.GREEN,
        ));
        curWidth -= width / 4;
      }
      if (item == 'Stench') {
        stackChildren.add(Container(
          width: curWidth,
          height: curWidth,
          color: GameColor.VIOLET,
        ));
        curWidth -= width / 4;
      }
      if (item == 'Empty') {
        stackChildren.add(Container(
          width: curWidth,
          height: curWidth,
          color: GameColor.GRAY,
        ));
        curWidth -= width / 4;
      }
      if (item == 'Base') {
        stackChildren.add(Container(
          width: curWidth,
          height: curWidth,
          color: Colors.black,
        ));
      }
    }
    return Stack(
      alignment: Alignment.center,
      children: stackChildren,
    );
  }
}
