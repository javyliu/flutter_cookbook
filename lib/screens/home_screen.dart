import 'package:cookbook/size_config.dart';
import 'package:flutter/material.dart';

import 'components/categories.dart';
import 'components/discount_banner.dart';
import 'components/home_header.dart';
import 'components/section_title.dart';

class HomeScreen extends StatelessWidget {
  static String name = "首页";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(20)),
              HomeHeader(),
              SizedBox(height: getProportionateScreenHeight(30)),
              DiscountBanner(),
              SizedBox(height: getProportionateScreenHeight(30)),
              Categories(),
              SizedBox(height: getProportionateScreenHeight(30)),
              SectionTitle(
                title: "Special for you",
                press: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
