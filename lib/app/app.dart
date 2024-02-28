import 'package:flutter/material.dart';

import '../presentation/resources/theme_manager.dart';
import '../presentation/resources/routes_manager.dart';

class MyApp extends StatefulWidget {
  MyApp._internal(); // private constructoe
  int appState = 0;
  static final MyApp instance =
      MyApp._internal(); // we have inly a single instance
  factory MyApp() => instance; // factory for the class instance
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
    );
  }
}
