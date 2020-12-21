import 'package:flutter/material.dart';

import '../../size_config.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key key,
    this.title,
    this.press,
    this.moreText = "See More",
  }) : super(key: key);
  final String title;
  final String moreText;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(18),
              color: Colors.black,
            ),
          ),
          GestureDetector(
            child: Text(moreText),
            onTap: press,
          )
        ],
      ),
    );
  }
}
