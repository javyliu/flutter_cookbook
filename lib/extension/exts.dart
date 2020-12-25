extension StrExt on String {
  ///transform constant to underscore string
  ///ex: "HelloWorld".underscore => "hello_world"
  String underscore() {
    return this.replaceAllMapped(RegExp(r'\B[A-Z]'), (Match m) => "_${m.group(0)}").toLowerCase();
    // str = str.replaceFirst("_", "");
    // return str;
  }

  String toRoutePath() {
    return "/$this";
  }

  // ignore: non_constant_identifier_names
  int get to_i {
    try {
      return int.parse(this);
    } catch (e) {
      final reg = RegExp(r'\d+');
      var mat = reg.stringMatch(this) ?? "0";
      return mat.to_i;
    }
  }
}

extension ListExt<E> on List<E> {
  E detect(bool test(E element), {E orElse()}) {
    try {
      return firstWhere(test, orElse: orElse);
    } catch (e) {
      return null;
    }
  }
}
