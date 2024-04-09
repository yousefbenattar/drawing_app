import 'package:flutter/material.dart';
import 'core/route/route.dart';
import 'core/route/route_name.dart';
import 'core/theme/theme.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Drawing Apps",
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      initialRoute: AppRouteName.drawingRoom,
      onGenerateRoute: AppRoute.generate,
      navigatorObservers: [routeObserver],
    );
  }
}