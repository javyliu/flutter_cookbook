import 'package:flutter/material.dart';

class CommonUtils {
  ///判断是否Debug模式
  static bool isDebug() {
    bool inDebug = false;
    assert(inDebug = true);
    return inDebug;
  }

  ///判断是否编译模式
  static String compileMode() {
    const bool isProfile = const bool.fromEnvironment("dart.vm.profile");
    const bool isReleaseMode = const bool.fromEnvironment("dart.vm.product");
    if (isDebug()) {
      return "debug";
    } else if (isProfile) {
      return "profile";
    } else if (isReleaseMode) {
      return "release";
    } else {
      return "Unknown type";
    }
  }

  static void hideKeyboard(BuildContext context) {
    FocusScopeNode curFocus = FocusScope.of(context);
    if (!curFocus.hasPrimaryFocus) {
      curFocus.unfocus();
    }
  }
}
