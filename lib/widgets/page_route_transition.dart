import 'package:flutter/material.dart';

class PageRouteTransition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          child: Text("Go"),
          onPressed: () {
            Navigator.of(context).push(_createRoute1());
          },
        ),
      ),
    );
  }
}

// Route _createRoute0() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => Page2(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
//   );
// }

// Route _createRoute() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => Page2(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       var begin = Offset(0, 1.0);
//       var end = Offset.zero;
//       var curve = Curves.ease;
//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//       var offsetAnimation = animation.drive(tween);

//       return SlideTransition(
//         position: offsetAnimation,
//         child: child,
//       );
//     },
//   );
// }

Route _createRoute1() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Page2(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;
      var tween = Tween(begin: begin, end: end);
      var curveAnimation = CurvedAnimation(parent: animation, curve: curve);

      return SlideTransition(
        position: tween.animate(curveAnimation),
        child: child,
      );
    },
  );
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Page 2'),
      ),
    );
  }
}
