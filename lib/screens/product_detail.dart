import 'dart:ui';

import 'package:cookbook/components/custom_app_bar.dart';
import 'package:cookbook/components/default_btn.dart';
import 'package:cookbook/models/product.dart';
import 'package:cookbook/size_config.dart';
import 'package:flutter/material.dart';

import 'components/product_colors.dart';
import 'components/product_description.dart';
import 'components/product_images.dart';
import 'components/top_rounded_container.dart';

class ProductDetail extends StatelessWidget {
  static String name = "产品详情";
  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Color(0xfff5f6f9),
      appBar: CustomAppBar(rating: product.rating),
      body: ListView(
        children: [
          ProductImages(product: product),
          TopRoundedContainer(
            child: Column(
              children: [
                ProductDescription(
                  product: product,
                  pressOnSeeMore: () {
                    print("hello");
                  },
                ),
                TopRoundedContainer(
                  color: Color(0xfff6f7f9),
                  child: Column(
                    children: [
                      ProductColors(product: product),
                      TopRoundedContainer(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(SizeConfig.screenWidth * 0.15, getProportionateScreenWidth(15), SizeConfig.screenWidth * 0.15, getProportionateScreenWidth(40)),
                          child: DefaultBtn(
                            text: "Add to Cart",
                            press: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
