import 'package:drawing_app/view/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import '../model/point.dart';
import '../controller/drawing_controller.dart';

class DrawingRoomScreen extends StatefulWidget {
  const DrawingRoomScreen({super.key});

  @override
  State<DrawingRoomScreen> createState() => _DrawingRoomScreenState();
}

class _DrawingRoomScreenState extends DarawingController {

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
              color: Colors.white,
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
                  child: SizedBox(
                    
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
              btn0(),
              btn1(),
              btn2(),
              btn3(),
              btn4(),
              btn5(),
            ],
                    ),
                  ),
            ),
          )
        ],
      )),
      /*floatingActionButton: SingleChildScrollView(
        padding: const EdgeInsets.only(right: 10.0,left: 10),
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            
            const SizedBox(width: 8),
            btn0(),
            btn1(),
            btn2(),
            btn3(),
            btn4(),
            btn5(),
          ],
        ),
      ),*/
      bottomNavigationBar:const BottomAppBar(/*color: Colors.blue,*/),
    );
  }
  Padding btn0 (){ return Padding(
    padding: const EdgeInsets.only(right: 10.0,left: 20),
    child: FloatingActionButton(heroTag: 'Undo',onPressed: () {
      if(drawingPoints.isNotEmpty&&historyDrawingPoints.isNotEmpty){setState(() {
        drawingPoints.removeLast();});}}
        ,child: const Icon(Icons.undo)),
  ); } 
  Padding btn1 (){ return Padding(
    padding: const EdgeInsets.only(right: 10.0,left: 20),
    child:FloatingActionButton(heroTag: 'ReDo',onPressed: () {setState(() {
    if(drawingPoints.length<historyDrawingPoints.length ){final index = drawingPoints.length;
   drawingPoints.add(historyDrawingPoints[index]);}});},child: const Icon(Icons.redo),),
  ); } 
  Padding btn2 (){ return Padding(
    padding: const EdgeInsets.only(right: 10.0,left: 20),
    child: FloatingActionButton(onPressed: (){
          setState(() {
            if (selectedWidth < 20) {
              selectedWidth = selectedWidth + 2;
            }
          });
    },child:const Icon(Icons.add),),
  ); }
  Padding btn3 (){ return Padding(
    padding: const EdgeInsets.only(right: 10.0,left: 20),
    child: FloatingActionButton(onPressed: (){
          setState(() {
            if (selectedWidth > 2) {
              selectedWidth = selectedWidth - 2;
            }
          });
    },child:const Icon(Icons.remove),),
  ); }
  Padding btn4 (){ return Padding(
    padding: const EdgeInsets.only(right: 10.0,left: 20),
    child: FloatingActionButton(onPressed: (){
      saveToGallery(context);
    },child:const Icon(Icons.save),),
  ); }
  Padding btn5 (){ return Padding(
    padding: const EdgeInsets.only(right: 10.0,left: 20),
    child: FloatingActionButton(onPressed: (){
      delete ();
    },child:const Icon(Icons.delete),),
  ); }
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






/*



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
                  )
                  )
                  ),
*/