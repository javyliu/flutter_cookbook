class Utils {
  ///判断是否Debug模式
  bool isDebug() {
    bool inDebug = false;
    assert(inDebug = true);
    return inDebug;
  }

  ///判断是否编译模式
  String compileMode() {
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
}
