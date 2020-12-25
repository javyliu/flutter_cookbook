import 'package:cookbook/components/default_btn.dart';
import 'package:cookbook/constants.dart';
import 'package:flutter/material.dart';

import '../../components/form_error.dart';
import '../../size_config.dart';
import 'custom_icon.dart';

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
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, "/forgot_password"),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
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
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                Navigator.pushNamed(context, "/login_success");
              }
            },
          )
        ],
      ),
    );
  }

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
