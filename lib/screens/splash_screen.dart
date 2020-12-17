import 'package:cookbook/size_config.dart';
import 'package:flutter/material.dart';

import 'components/splash_body.dart';

class SplashScreen extends StatelessWidget {
  static String name = '初始闪屏';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(name),
      // ),
      body: Body(),
    );
  }
}
