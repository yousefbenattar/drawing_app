import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import '../model/permission_handler.dart';
import '../model/point.dart';
import '../view/drawing_screen.dart';
import 'dart:typed_data';

abstract class DarawingController extends State<DrawingRoomScreen>{
  var historyDrawingPoints = <DrawingPoint>[];
  var drawingPoints = <DrawingPoint>[];
  DrawingPoint? currentDrawingPoint;
  var selectedColor = Colors.black;
  var selectedWidth = 2.0;
ScreenshotController screenshotController = ScreenshotController();
  saveToGallery(BuildContext context){
      screenshotController.capture().then((Uint8List? image){saveImage(image!);
        ScaffoldMessenger.of(context).showSnackBar(
     const SnackBar(content: Text('Image Saved to gallery',style: TextStyle(fontSize: 16),))
    );
    }
      ).catchError((error)=> null);
  }
  saveImage(Uint8List bytes) async {
    final time = DateTime.now().toIso8601String().replaceAll('.', '-').replaceAll(':', '-');
    final name = "screenshot_$time";
    await requestPermission(Permission.storage);
    await ImageGallerySaver.saveImage(bytes,name: name);
  }
delete (){
  setState(() {
    drawingPoints.clear();
    historyDrawingPoints.clear();
  });
}

}