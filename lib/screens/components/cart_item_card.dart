import 'package:cookbook/models/cart_item.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    Key key,
    @required this.cartItem,
  }) : super(key: key);
  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, "/product_detail", arguments: cartItem.product),
      child: Row(
        children: [
          SizedBox(
            width: getProportionateScreenWidth(88),
            child: AspectRatio(
              aspectRatio: 0.88,
              child: Container(
                child: Image.asset(cartItem.product.images[0]),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(color: Color(0xfff5f6f9), borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ),
          SizedBox(width: getProportionateScreenWidth(20)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(cartItem.product.title, style: TextStyle(fontSize: 16, color: Colors.black)),
              const SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  text: "\$${cartItem.product.price}",
                  style: TextStyle(color: jPrimaryColor),
                  children: [
                    TextSpan(
                      text: " x ${cartItem.nums}",
                      style: TextStyle(color: jTextColor),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
