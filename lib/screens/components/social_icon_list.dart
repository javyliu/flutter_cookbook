import 'package:flutter/material.dart';

import 'social_card.dart';

class SocialIconList extends StatelessWidget {
  const SocialIconList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialCard(
          icon: "assets/icons/google-icon.svg",
          press: () {},
        ),
        SocialCard(
          icon: "assets/icons/facebook-2.svg",
          press: () {},
        ),
        SocialCard(
          icon: "assets/icons/twitter.svg",
          press: () {},
        ),
      ],
    );
  }
}
