import 'package:cookbook/components/default_btn.dart';
import 'package:cookbook/constants.dart';
import 'package:cookbook/models/cart_item.dart';
import 'package:cookbook/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'components/cart_item_card.dart';

class CartScreen extends StatefulWidget {
  static String name = "购物车";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(CartScreen.name),
            Text("${demoCartItems.length} items"),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: ListView.builder(
          itemCount: demoCartItems.length,
          itemBuilder: (context, index) {
            var _item = demoCartItems[index];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Dismissible(
                key: Key(_item.product.id.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color(0xffffe6e6),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Spacer(),
                      // SvgPicture.asset("assets/icons/Trash.svg"),
                      // Icon(Icons.delete, color: Colors.amber),
                      Icon(Icons.highlight_remove, color: Colors.black45),
                    ],
                  ),
                ),
                child: CartItemCard(cartItem: _item),
                onDismissed: (direction) {
                  setState(() {
                    demoCartItems.removeAt(index);
                  });
                },
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15), horizontal: getProportionateScreenWidth(30)),
        // height: 174,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -15),
              blurRadius: 20,
              color: Color(0xffdadada).withOpacity(0.35),
            ),
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    width: getProportionateScreenWidth(40),
                    height: getProportionateScreenWidth(40),
                    decoration: BoxDecoration(
                      color: Color(0xfff5f6f9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset("assets/icons/receipt.svg"),
                  ),
                  Spacer(),
                  Text("Add voucher code"),
                  const SizedBox(width: 10),
                  Icon(Icons.arrow_forward_ios, size: 12, color: jTextColor),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Total:\n",
                      children: [
                        TextSpan(
                          text: "\$337.15",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(190),
                    child: DefaultBtn(
                      text: "Check Out",
                      press: () {},
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
