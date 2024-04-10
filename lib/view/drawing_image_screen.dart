import 'package:drawing_app/view/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import '../controller/drawing_image_controller.dart';
import '../model/point.dart';


class DrawingImageRoomScreen extends StatefulWidget {
  const DrawingImageRoomScreen({super.key});

  @override
  State<DrawingImageRoomScreen> createState() => _DrawingImageRoomScreenState();
}

class _DrawingImageRoomScreenState extends DarawingImageController {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: SizedBox(
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
                  onTap: () {
                    setState(() {
                  selectedColor = avaiableColor[index];});},
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(/*width: 2, color: Colors.black*/),
                      color: avaiableColor[index],
                      shape: BoxShape.circle,
                    ),
                    foregroundDecoration: BoxDecoration(
                    border: selectedColor == avaiableColor[index]
                      ? Border.all(
                    width: 4,
                    color: AppColor.primaryColor,
                    )
                  : null,
              shape: BoxShape.circle,),),);},)),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Screenshot(
            controller: screenshotController,
            child: Container(
                decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/1.png"),fit: BoxFit.fill)
                    ),
              //color: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/*- 220*/,
              //color: Colors.blue,
              child: GestureDetector(
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
                  child: Container(
                  
                   // color: Colors.white,
                    height:MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
            //margin:const EdgeInsets.all(8),
            //padding:const EdgeInsets.all(8),
            color: Colors.white,
            //height: 60,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
                    padding: const EdgeInsets.only(right: 10.0,left: 10),
                    scrollDirection: Axis.horizontal,
                    child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              
              const SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: iconbtn(const Icon(Icons.undo), () {if (drawingPoints.isNotEmpty &&historyDrawingPoints.isNotEmpty) {setState(() {drawingPoints.removeLast();});}}),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: iconbtn(const Icon(Icons.redo), () {setState(() {if (drawingPoints.length <historyDrawingPoints.length) {final index = drawingPoints.length;drawingPoints.add(historyDrawingPoints[index]);}});}),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: iconbtn(const Icon(Icons.add), () {setState(() {if (selectedWidth < 26) {selectedWidth = selectedWidth + 2;}});}),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: iconbtn(const Icon(Icons.remove), () {setState(() {if (selectedWidth > 2) {selectedWidth = selectedWidth - 2;}});}),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: iconbtn(const Icon(Icons.delete), () {delete();}),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: iconbtn(const Icon(Icons.save), () {saveToGallery(context);}),
                    ),
                 ],
                ),
              ),
            ),
          )
        ],
      )),

      bottomNavigationBar:const BottomAppBar(/*color: Colors.blue,*/),
    );
  }
   IconButton iconbtn (Icon icon,dynamic function ){return IconButton(
    padding:const EdgeInsets.all(10),
    onPressed: function, icon:icon,color: Colors.black,iconSize: 40,);}
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
