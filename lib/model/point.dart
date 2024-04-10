import 'package:flutter/material.dart';

class DrawingPoint {
  int id;
  List<Offset> offsets;
  Color color;
  double width;

  DrawingPoint({
    this.id = -1,
    this.offsets = const [],
    this.color = Colors.black,
    this.width = 2,
  });

  DrawingPoint copyWith({List<Offset>? offsets}) {
    return DrawingPoint(
      id: id,
      color: color,
      width: width,
      offsets: offsets ?? this.offsets,
    );
  }
}

  List<Color> avaiableColor = [
    Colors.black,
    Colors.white,
    Colors.grey,
    Colors.blueGrey,
    Colors.red,
    Colors.redAccent,
    Colors.yellow,
    Colors.yellowAccent,
    Colors.amber,
    Colors.amberAccent,
    Colors.orange,
    Colors.orangeAccent,
    Colors.lightBlue,
    Colors.lightBlueAccent,
    Colors.blue,
    Colors.blueAccent,
    Colors.lightGreen,
    Colors.lightGreenAccent,
    Colors.green,
    Colors.greenAccent,
    Colors.cyan,
    Colors.cyanAccent,
    Colors.brown,
    Colors.pink,
    Colors.pinkAccent,
    Colors.purple,
    Colors.purpleAccent,
    Colors.indigo,
    Colors.indigoAccent,
  ];