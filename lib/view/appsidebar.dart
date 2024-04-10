import 'package:flutter/material.dart';

import '../main.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  void _toggleTheme(BuildContext context) {
    setState(() {
      ThemeMode currentTheme = Theme.of(context).brightness == Brightness.light ? ThemeMode.light : ThemeMode.dark;
      ThemeMode newTheme = currentTheme == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
      Navigator.pop(context); // Close the drawer
      // Update the theme mode directly within MyApp
      MyApp.of(context)?.updateThemeMode(newTheme);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header') ,
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Toggle Theme'),
            onTap: () {
              _toggleTheme(context);
            },
          ),
          // Other list items for the drawer can be added here
        ],
      ),
    );
  }
}