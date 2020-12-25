import 'package:cookbook/components/default_btn.dart';
import 'package:flutter/material.dart';

import '../size_config.dart';

class LoginSuccess extends StatelessWidget {
  static String name = '登录成功';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //如果要取消返回箭头的话，加上一个SizeBox即可
        leading: SizedBox(),
        title: Text(name),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            Expanded(
              child: Image.asset(
                "assets/images/success.png",
                height: SizeConfig.screenHeight * 0.4,
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.08),
            Text(
              "Login Success",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(30),
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.04),
            SizedBox(
              width: SizeConfig.screenWidth * 0.8,
              child: DefaultBtn(
                text: "Back to Home",
                press: () => Navigator.pushNamed(context, "/home_screen"),
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.2),
          ],
        ),
      ),
    );
  }
}
