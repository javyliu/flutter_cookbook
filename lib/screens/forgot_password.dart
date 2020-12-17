import 'dart:developer';

import 'package:cookbook/components/default_btn.dart';
import 'package:cookbook/components/form_error.dart';
import 'package:cookbook/screens/components/no_account_text.dart';
import 'package:cookbook/size_config.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'components/custom_icon.dart';

class ForgotPassword extends StatelessWidget {
  static String name = "找回密码";

  @override
  Widget build(BuildContext context) {
    log((ForgotPassword).toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Text(
                  "Forget Password",
                  style: TextStyle(fontSize: getProportionateScreenWidth(28), color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text("Please enter your email and we will send \n you a link to return to your account!", textAlign: TextAlign.center),
                SizedBox(height: SizeConfig.screenHeight * 0.14),
                ForgotForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.19),
                NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ForgotForm extends StatefulWidget {
  @override
  _ForgotFormState createState() => _ForgotFormState();
}

class _ForgotFormState extends State<ForgotForm> {
  String email;
  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
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
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.08),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.01),
          DefaultBtn(
            text: "Continue",
            press: () {
              log("---get password");
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
              }
            },
          ),
        ],
      ),
    );
  }
}
