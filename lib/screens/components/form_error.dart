import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FormError extends StatelessWidget {
  const FormError({
    Key key,
    @required this.errors,
  }) : super(key: key);

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(errors.length, (index) => buildErrorRow(errors[index])),
    );
  }

  Row buildErrorRow(String error) {
    return Row(
      children: [
        SvgPicture.asset(
          "assets/icons/Error.svg",
          height: 14,
          width: 14,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            error,
            style: TextStyle(color: Colors.red),
          ),
        )
      ],
    );
  }
}
