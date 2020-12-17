import 'package:flutter/material.dart';

import '../../constants.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Dont't have an account?"),
        GestureDetector(
          onTap: () => Navigator.popAndPushNamed(context, "/sign_up"),
          child: Text(
            "Sign Up",
            style: TextStyle(color: jPrimaryColor),
          ),
        )
      ],
    );
  }
}
