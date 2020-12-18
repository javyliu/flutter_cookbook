import 'dart:developer';

import 'package:flutter/material.dart';

import '../../components/default_btn.dart';
import '../../components/form_error.dart';
import '../../constants.dart';
import '../../size_config.dart';
import 'custom_icon.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  String confirmPassword;
  List<String> errors = [];

  void addError(String err) {
    if (!errors.contains(err)) {
      setState(() {
        errors.add(err);
      });
    }
  }

  void removeError(String err) {
    if (errors.contains(err)) {
      setState(() {
        errors.remove(err);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPwdField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConfirmPwdField(),
          SizedBox(height: getProportionateScreenHeight(40)),
          FormError(errors: errors),
          DefaultBtn(
            text: "Continue",
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                Navigator.pushNamed(context, "complete_profile");

                //go to complete profile page
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildConfirmPwdField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) {
        log("---confirm onsaved...");
        return confirmPassword = newValue;
      },
      decoration: InputDecoration(
        hintText: "Re-enter your password",
        labelText: "Confirm Password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomIcon(
          img: "assets/icons/Lock.svg",
        ),
      ),
      validator: (value) {
        log("----value: $value ---password: $password ");
        if (value.isEmpty) {
          return "";
        } else if (value != password) {
          addError(jMatchPassError);
          return "";
        }
        return null;
      },
      onChanged: (value) {
        if (value.isNotEmpty && password == value) {
          removeError(jMatchPassError);
        }
        return null;
      },
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
          addError(jPasswordNullError);
          return "";
        } else if (value.length < 4) {
          addError(jShortPassError);
          return "";
        }
        return null;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(jPasswordNullError);
        } else if (value.length >= 4) {
          removeError(jShortPassError);
        }
        password = value;
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
          addError(jEmailNullError);
          return "";
        } else if (!emailRegExp.hasMatch(value)) {
          addError(jInvalidEmailError);
          return "";
        }
        return null;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(jEmailNullError);
        } else if (emailRegExp.hasMatch(value)) {
          removeError(jInvalidEmailError);
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
