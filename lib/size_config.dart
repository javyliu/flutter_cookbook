import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double defaultSize;
  static Orientation orientation;

  ///在实列方法中也可以访问静态变量
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

///Get the proportionate height as per screen size
double getProportionateScreenHeight(double height) {
  double screenHeight = SizeConfig.screenHeight;

  ///812 is the layout height that designer use
  return (screenHeight / 812.0) * height;
}

/// Get the proportionate width as per screen size
/// 用于调整设计尺寸和屏幕尺寸
double getProportionateScreenWidth(double width) {
  //屏幕：ios宽：414
  double screenWidth = SizeConfig.screenWidth;

  //375 is the layout width that designer use
  return (screenWidth / 375.0) * width;
}
