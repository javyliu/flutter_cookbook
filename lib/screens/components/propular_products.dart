import 'dart:developer';

import 'package:cookbook/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'section_title.dart';

class PropularProducts extends StatelessWidget {
  const PropularProducts({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          title: "Popular Product",
          press: () {},
        ),
        SizedBox(height: getProportionateScreenHeight(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...List.generate(
                demoProducts.length,
                (index) => ProductCard(
                  product: demoProducts[index],
                  press: () {
                    log("----$index is pressed");
                  },
                  linkPress: () {
                    log("---product ${demoProducts[index].id} is press");
                  },
                ),
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    this.width = 140,
    this.aspectRetion = 1.02,
    @required this.product,
    this.press,
    this.linkPress,
  }) : super(key: key);
  final double width, aspectRetion;
  final Product product;
  final GestureTapCallback press;
  final GestureTapCallback linkPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        height: 230,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: linkPress,
              child: AspectRatio(
                aspectRatio: aspectRetion,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                  decoration: BoxDecoration(
                    color: jSecondaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.asset(product.images[0]),
                ),
              ),
            ),
            Text(product.title, maxLines: 2, style: TextStyle(color: Colors.black)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${product.price}",
                  style: TextStyle(
                    color: jPrimaryColor,
                    fontSize: getProportionateScreenWidth(18),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InkWell(
                  onTap: press,
                  child: Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                    width: getProportionateScreenWidth(28),
                    height: getProportionateScreenWidth(28),
                    decoration: BoxDecoration(
                      color: product.isFavourite ? jPrimaryColor.withOpacity(0.15) : jSecondaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/Heart\ Icon_2.svg",
                      color: product.isFavourite ? Colors.red : jSecondaryColor,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
