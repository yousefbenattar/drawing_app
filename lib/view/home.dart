import 'package:flutter/material.dart';

import 'appsidebar.dart';
import 'drawing_image_screen.dart';
import 'drawing_screen.dart';
import 'gallery_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer:const SideBar(),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(children: [
            Container(
              height: 200,
              width: 200,
              decoration:const BoxDecoration(image: DecorationImage(image: AssetImage("assets/icon.png"),fit: BoxFit.fill)),
            ),
            InkWell(
              onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (builder)=> const DrawingRoomScreen()));
              },
              child: container(const Icon(Icons.draw,size: 50,),Color.fromARGB(255, 123, 209, 235))),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (builder)=> const DrawingImageRoomScreen()));
              },
              child: container(const Icon(Icons.work_history,size: 50,),const Color.fromARGB(255, 238, 230, 163))),
          ],),
        ),
      ),
    );
  }
  Container container (Icon icon,Color color){
    return  Container(
      margin:const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: color
              ),
              width: 300,
              height: 150,
              child: icon,
            );
  }
}