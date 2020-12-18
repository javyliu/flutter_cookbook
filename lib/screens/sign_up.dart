import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';
import 'components/sign_up_form.dart';
import 'components/social_icon_list.dart';

class SignUp extends StatelessWidget {
  static String name = "注册用户";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Register Account",
                  style: headingStyle,
                ),
                Text(
                  "Complete your details or continue \n with social media",
                  textAlign: TextAlign.center,
                ),
                SignUpForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.07),
                SocialIconList(),
                SizedBox(height: SizeConfig.screenHeight * 0.07),
                Text(
                  "By continueing your confirm that your agree\n with out Term and Condition.",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
