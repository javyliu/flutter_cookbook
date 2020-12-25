import 'package:cookbook/extension/common_utils.dart';
import 'package:flutter/material.dart';

import '../../size_config.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Cart\ Icon.svg",
            numOfItems: 0,
            press: () {
              CommonUtils.hideKeyboard(context);

              return Navigator.pushNamed(context, "cart_screen");
            },
          ),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Bell.svg",
            numOfItems: 3,
            press: () {},
          ),
        ],
      ),
    );
  }
}
