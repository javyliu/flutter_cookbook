import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key key,
    this.icon,
    this.title,
    this.press,
  }) : super(key: key);
  final String icon;
  final String title;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          primary: Color(0xfff5f6f9),
        ),
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(icon, width: 22, color: jPrimaryColor),
            const SizedBox(width: 20),
            Expanded(child: Text(title, style: Theme.of(context).textTheme.bodyText1)),
            Icon(Icons.arrow_forward_ios, color: jSecondaryColor)
          ],
        ),
      ),
    );
  }
}
