import 'package:cookbook/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';
import '../../size_config.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key key,
    @required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  final Product product;
  final GestureTapCallback pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          product.title,
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(height: 5),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(15)),
            width: getProportionateScreenWidth(64),
            decoration: BoxDecoration(
              color: product.isFavourite ? Color(0xffffe6e6) : Color(0xfff5f6f9),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: SvgPicture.asset(
              "assets/icons/Heart\ Icon_2.svg",
              color: product.isFavourite ? Color(0xffff4848) : Color(0xffdbdee4),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: Text(
            product.description,
            maxLines: 3,
          ),
        ),
        GestureDetector(
          onTap: pressOnSeeMore,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20), vertical: 10),
            child: Row(
              children: [
                Text("See More Detail", style: TextStyle(color: jPrimaryColor, fontWeight: FontWeight.w600)),
                SizedBox(width: 5),
                Icon(Icons.arrow_forward_ios, size: 12, color: jPrimaryColor),
              ],
            ),
          ),
        )
      ],
    );
  }
}
