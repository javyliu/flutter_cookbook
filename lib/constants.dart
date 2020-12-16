import 'package:flutter/material.dart';

const jPrimaryColor = Color(0xFFFF7643);
const jPrimaryLightColor = Color(0xFFFFECDF);
const jPrimaryGradientColor = LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFFFFA53E), Color(0xFFFF7643)]);
const jSecondaryColor = Color(0xFF979797);
const jTextColor = Color(0xFF757575);
const jAnimationDuration = Duration(milliseconds: 200);

//Form error
final RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String jEmailNullError = "Please Enter your email";
const String jInvalidEmailError = "Please Enter Valid Email";
const String jPasswordNullError = "Please enter our password";
const String jShortPassError = "Password is too short";
const String jMatchPassError = "Passwords don't match";
