import 'package:flutter/material.dart';

import '../presentation/resources/theme_manager.dart';
import '../presentation/resources/routes_manager.dart';

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  MyApp._internal(); // private constructoe
  int appState = 0;
  static final MyApp instance = MyApp
      ._internal(); // we have a single instance. The singleton pattern ensures that a class has only one instance and provides a global point of access to it.
  // This can be particularly useful for managing application-wide state or resources that should be consistent and unique, such as theme and route management.
  factory MyApp() =>
      instance; // The factory constructor returns the single instance stored in the instance field. When MyApp() is called, it does not create a new instance but returns the existing instance.
  @override
  _MyAppState createState() => _MyAppState();
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
