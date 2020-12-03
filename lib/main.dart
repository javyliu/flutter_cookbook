import 'package:flutter/material.dart';

import './routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      routes: routes(),
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
        fontFamily: 'Georgia',
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14, fontFamily: 'Hind'),
        ),
      ),
      // home: FadeWidget(),
    );
  }
}
