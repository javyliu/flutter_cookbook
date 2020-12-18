import 'package:cookbook/constants.dart';
import 'package:cookbook/widgets/menu_list.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';

import './routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // runApp(MyApp());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "splash_screen",
      routes: routes(),
      theme: buildThemeData(),
    );
  }

  ///统一的设置主题
  ThemeData buildThemeData() {
    var _border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: BorderSide(color: jTextColor),
      gapPadding: 10,
    );
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black),
        textTheme: TextTheme(
          headline6: TextStyle(color: jSecondaryColor),
        ),
      ),
      tabBarTheme: TabBarTheme(
        labelColor: Colors.orange,
        unselectedLabelColor: Colors.black12,
        labelStyle: TextStyle(
          color: Colors.black,
          backgroundColor: Colors.green,
        ),
      ),

      fontFamily: 'Muli',
      textTheme: TextTheme(
        bodyText1: TextStyle(color: jTextColor),
        bodyText2: TextStyle(color: jTextColor),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      inputDecorationTheme: InputDecorationTheme(
        //floatingLabelBehavior 放在这里不起作用，应放在inputDecoration中
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 38,
          vertical: 20,
        ),
        enabledBorder: _border,
        focusedBorder: _border,
        border: _border,
      ),

      // brightness: Brightness.light,
      // primaryColor: Colors.lightBlue[800],
      // accentColor: Colors.cyan[600],
      // textTheme: TextTheme(
      //   headline1: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
      //   headline6: TextStyle(fontSize: 36, fontStyle: FontStyle.italic),
      //   bodyText2: TextStyle(fontSize: 14, fontFamily: 'Hind'),
      // ),
    );
  }
}

class SplaScrs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen.navigate(
      name: "assets/images/intro.flr",
      next: (context) => MenuList(),
      until: () => Future.delayed(Duration(seconds: 4)),
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
