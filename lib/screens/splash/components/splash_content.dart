import 'package:flutter/material.dart';

import '../../../constants.dart';

class SplashContent extends StatelessWidget {
  final String text, image;
  const SplashContent({Key key, this.text, this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(
          flex: 1,
        ),
        Text("TOKOTO", style: TextStyle(fontSize: 36, color: jPrimaryColor, fontWeight: FontWeight.bold)),
        Text(text, textAlign: TextAlign.center),
        Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 4,
          child: Image.asset(
            image,
          ),
        ),
      ],
    );
  }
}
