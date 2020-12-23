import 'package:cookbook/components/custom_app_bar.dart';
import 'package:cookbook/models/product.dart';
import 'package:flutter/material.dart';

import '../../size_config.dart';
import 'colored_dot.dart';

class ProductColors extends StatelessWidget {
  const ProductColors({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    int selectedIdx = 3;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        children: [
          ...List.generate(
            product.colors.length,
            (index) => ColoredDot(color: product.colors[index], selected: selectedIdx == index),
          ),
          Spacer(),
          RoundedIconBtn(
            iconData: Icons.remove,
            press: () {},
          ),
          const SizedBox(width: 20),
          RoundedIconBtn(
            iconData: Icons.add,
            press: () {},
          ),
        ],
      ),
    );
  }
}
