import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';

class ColoredDot extends StatelessWidget {
  const ColoredDot({
    Key key,
    this.color,
    this.selected = false,
  }) : super(key: key);
  final Color color;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 2),
      padding: EdgeInsets.all(8),
      height: getProportionateScreenWidth(40),
      width: getProportionateScreenWidth(40),
      decoration: BoxDecoration(
        // color: product.colors[0],
        shape: BoxShape.circle,
        border: Border.all(color: selected ? jPrimaryColor : Colors.transparent),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}
