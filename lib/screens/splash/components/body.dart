import 'dart:developer';

import 'package:cookbook/constants.dart';
import 'package:cookbook/size_config.dart';
import 'package:flutter/material.dart';

import '../../../components/default_btn.dart';
import 'splash_content.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentIdx = 0;
  List<Map<String, String>> splashData = [
    {"text": "Welcome to Tokoto, Let's shop!", "image": "assets/images/splash_1.png"},
    {"text": "We help people connect with store \n around United State of America", "image": "assets/images/splash_2.png"},
    {"text": "We show the easy way to shop. \nJust stay at home with us", "image": "assets/images/splash_3.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                itemCount: splashData.length,
                onPageChanged: (value) {
                  setState(() {
                    currentIdx = value;
                  });
                },
                itemBuilder: (context, index) {
                  log("---$index");

                  return SplashContent(
                    text: splashData[index]["text"],
                    image: splashData[index]["image"],
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: [
                    Spacer(flex: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(splashData.length, (index) => buildDots(index)),
                    ),
                    Spacer(flex: 4),
                    DefaultBtn(
                      text: "Continue",
                      press: () {
                        Navigator.pushNamed(context, "/sign_in");
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
              flex: 2,
            )
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDots(int idx) {
    return AnimatedContainer(
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: idx == currentIdx ? 20 : 6,
      decoration: BoxDecoration(
        color: idx == currentIdx ? jPrimaryColor : jSecondaryColor,
        borderRadius: BorderRadius.circular(3),
      ),
      duration: jAnimationDuration,
    );
  }
}
