import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      backgroundColor :Colors.white,
      //loaderColor: Colors.white,
      logo: Image.asset(
          'assets/icon.png'),
      title:const Text(
        "Funny Drawing App",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      //backgroundColor: Colors.grey.shade400,
      showLoader: true,
      loadingText:const Text("Loading..."),
      navigator:const Home(),
      durationInSeconds: 5,
    );
  }
}