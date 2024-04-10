import 'package:flutter/material.dart';
import 'view/home.dart';
void main() {
  runApp(MyApp(themeMode: ThemeMode.light));
}

class MyApp extends StatefulWidget {
  final ThemeMode themeMode;

  const MyApp({Key? key, required this.themeMode}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) {
    return context.findAncestorStateOfType<_MyAppState>();
  }
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.dark;

  void updateThemeMode(ThemeMode newThemeMode) {
    setState(() {
      themeMode = newThemeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Funny Drawing App",
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      home:const Home(),
    );
  }
}