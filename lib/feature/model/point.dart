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
    Colors.red,
    Colors.redAccent,
    Colors.yellow,
    Colors.yellowAccent,
    Colors.amber,
    Colors.orange,
    Colors.orangeAccent,
    Colors.blue,
    Colors.blueAccent,
    Colors.green,
    Colors.greenAccent,
    Colors.cyan,
    Colors.cyanAccent,
    Colors.brown,
    Colors.pink,
    Colors.pinkAccent,
    Colors.purple,
    Colors.indigo,
    Colors.purpleAccent,
  ];