import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomIcon extends StatelessWidget {
  final String img;
  const CustomIcon({
    Key key,
    @required this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 20, 20),
      child: SvgPicture.asset(img, height: 18),
    );
  }
}
