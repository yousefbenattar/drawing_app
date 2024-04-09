import 'package:drawing_app/core/theme/color.dart';
import 'package:flutter/material.dart';

import '../model/point.dart';

class DrawingRoomScreen extends StatefulWidget {
  const DrawingRoomScreen({super.key});

  @override
  State<DrawingRoomScreen> createState() => _DrawingRoomScreenState();
}

class _DrawingRoomScreenState extends State<DrawingRoomScreen> {
  var historyDrawingPoints = <DrawingPoint>[];
  var drawingPoints = <DrawingPoint>[];
  DrawingPoint? currentDrawingPoint;
  var selectedColor = Colors.black;
  var selectedWidth = 2.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          GestureDetector(
            onPanStart: (details) {
              setState(() {
                currentDrawingPoint = DrawingPoint(
                  id: DateTime.now().microsecondsSinceEpoch,
                  offsets: [details.localPosition],
                  color: selectedColor,
                  width: selectedWidth,
                );
                if (currentDrawingPoint == null) return;
                {
                  drawingPoints.add(currentDrawingPoint!);
                  historyDrawingPoints =List.of(drawingPoints);
                }
              });
              
            },
            onPanUpdate: (details) {
              setState(() {
                if (currentDrawingPoint == null) return;
                currentDrawingPoint = currentDrawingPoint?.copyWith(
                    offsets: currentDrawingPoint!.offsets
                      ..add(details.localPosition));
                                    drawingPoints.last = currentDrawingPoint!;
              historyDrawingPoints = List.of(drawingPoints);
              });

            },
            onPanEnd: (_) {
              setState(() {
                currentDrawingPoint = null;
              });
            },
            child: CustomPaint(
              painter: DrawingPainter(
                drawingPoints: drawingPoints,
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).padding.top,
              left: 16,
              right: 16,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: avaiableColor.length,
                    separatorBuilder: (_, __) {
                      return const SizedBox(width: 8);
                    },
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          setState(() {
                            selectedColor = avaiableColor[index];
                          });
                        },
                        child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(/*width: 2, color: Colors.black*/),
                              color: avaiableColor[index],
                              shape: BoxShape.circle,
                            ),
                            foregroundDecoration: BoxDecoration(
                              border:   selectedColor == avaiableColor[index] ?
                               Border.all(width: 4,color: AppColor.primaryColor,) : null,
                           shape:BoxShape.circle,  ),
                            ),
                      );
                    },
                  ))),
          Positioned(
              top: MediaQuery.of(context).padding.top + 80,
              right: 0,
              bottom: 150,
              child: RotatedBox(
                  quarterTurns: 3,
                  child: Slider(
                    min: 1,
                    max: 20,
                    value: selectedWidth,
                   onChanged: (value) {
                    setState(() {
                      selectedWidth = value;
                    });
                   })))
        ],
      )),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              heroTag: 'Undo',onPressed: () {
              if(drawingPoints.isNotEmpty&&historyDrawingPoints.isNotEmpty){
                setState(() {
                  drawingPoints.removeLast();
                });
              }
              },
               child: const Icon(Icons.undo)),
          const SizedBox(width: 8),
          FloatingActionButton(
            heroTag: 'ReDo',
            onPressed: () {
              setState(() {
                if(drawingPoints.length<historyDrawingPoints.length ){
                  final index = drawingPoints.length;
                  drawingPoints.add(historyDrawingPoints[index]);
                }
              });
            },
            child: const Icon(Icons.redo),
          ),
        ],
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  final List<DrawingPoint> drawingPoints;

  DrawingPainter({required this.drawingPoints});

  @override
  void paint(Canvas canvas, Size size) {
    for (var drawingPoint in drawingPoints) {
      final paint = Paint()
        ..color = drawingPoint.color
        ..isAntiAlias = true
        ..strokeWidth = drawingPoint.width
        ..strokeCap = StrokeCap.round;
      for (var i = 0; i < drawingPoint.offsets.length; i++) {
        var notLastOffset = i != drawingPoint.offsets.length - 1;
        if (notLastOffset) {
          final current = drawingPoint.offsets[i];
          final next = drawingPoint.offsets[i + 1];
          canvas.drawLine(current, next, paint);
        } else {
          /// - nothing
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
