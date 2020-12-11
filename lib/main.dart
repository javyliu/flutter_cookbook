import 'package:cookbook/widgets/menu_list.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';

import './routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // runApp(MyApp());
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
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
    ),
  );
}

class SplaScrs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen.navigate(
      name: "assets/images/intro.flr",
      next: (context) => MenuList(),
      until: () => Future.delayed(Duration(seconds: 10)),
      startAnimation: '1',
    );
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SplashScreen(
//       seconds: 14,
//       navigateAfterSeconds: MenuList(),
//       title: Text(
//         "Welcome In SplashScreen",
//         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
//       ),
//       image: Image.asset("assets/images/11.png"),
//       backgroundColor: Colors.white,
//       styleTextUnderTheLoader: TextStyle(),
//       photoSize: 100.0,
//       onClick: () => print("Flutter splashscreen"),
//       loaderColor: Colors.red,
//     );
//   }
// }

class EnterPoint extends StatelessWidget {
  const EnterPoint({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // onGenerateRoute: (settings) {
      //   log("--ongenerateRoute: $settings");
      //   return null;
      // },
      // home: PageRouteTransition(),
      // home: PhysicsCardDragDemo(),
      // home: AnimatedContainerApp(),
      initialRoute: '/',
      routes: routes(),
      // home: FadeWidget(),
    );
  }
}
