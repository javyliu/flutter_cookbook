import 'package:flutter/material.dart';

import './routes/app_routes.dart';

void main() {
  // runApp(MyApp());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: PageRouteTransition(),
      // home: PhysicsCardDragDemo(),
      // home: AnimatedContainerApp(),
      initialRoute: '/',
      routes: routes,
    );
  }
}
