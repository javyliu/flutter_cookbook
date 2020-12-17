import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class DefaultBtn extends StatelessWidget {
  final String text;
  final GestureTapCallback press;
  const DefaultBtn({
    Key key,
    this.text,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: jPrimaryColor,
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(fontSize: getProportionateScreenHeight(18), color: Colors.white),
        ),
      ),
    );
  }
}
