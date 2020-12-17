import 'package:flutter/material.dart';

import 'components/sign_body.dart';

class SignIn extends StatelessWidget {
  static String name = "登录";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Body(),
    );
  }
}
