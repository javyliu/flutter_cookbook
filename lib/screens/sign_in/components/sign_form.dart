import 'dart:developer';

import 'package:cookbook/components/default_btn.dart';
import 'package:cookbook/constants.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'custom_icon.dart';
import 'form_error.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String email;
  String password;
  bool remember = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildPwdField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: jPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text("Remember me"),
              Spacer(),
              Text(
                "Forgot Password",
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: FormError(errors: errors),
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultBtn(
            text: "Continue",
            press: () {
              log("===${errors.length}");
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
              }
            },
          )
        ],
      ),
    );
  }

  TextFormField buildPwdField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      decoration: InputDecoration(
        hintText: "Enter your password",
        labelText: "Password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomIcon(
          img: "assets/icons/Lock.svg",
        ),
      ),
      validator: (value) {
        if (value.isEmpty) {
          if (!errors.contains(jPasswordNullError)) {
            setState(() {
              errors.add(jPasswordNullError);
            });
          }
        } else if (value.length < 4) {
          if (!errors.contains(jShortPassError)) {
            setState(() {
              errors.add(jShortPassError);
            });
          }
        }
        return null;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          if (errors.contains(jPasswordNullError)) {
            setState(() {
              errors.remove(jPasswordNullError);
            });
          }
        } else if (value.length >= 4) {
          if (errors.contains(jShortPassError)) {
            setState(() {
              errors.remove(jShortPassError);
            });
          }
        }
        return null;
      },
    );
  }

  TextFormField buildEmailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      validator: (value) {
        if (value.isEmpty) {
          if (!errors.contains(jEmailNullError)) {
            setState(() {
              errors.add(jEmailNullError);
            });
          }
        } else if (!emailRegExp.hasMatch(value)) {
          if (!errors.contains(jInvalidEmailError)) {
            setState(() {
              errors.add(jInvalidEmailError);
            });
          }
        }
        return null;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          if (errors.contains(jEmailNullError)) {
            setState(() {
              errors.remove(jEmailNullError);
            });
          }
        } else if (emailRegExp.hasMatch(value)) {
          if (errors.contains(jInvalidEmailError)) {
            setState(() {
              errors.remove(jInvalidEmailError);
            });
          }
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Enter your email",
        labelText: "Email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomIcon(
          img: "assets/icons/Mail.svg",
        ),
      ),
    );
  }
}
