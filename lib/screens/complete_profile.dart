import 'package:cookbook/components/default_btn.dart';
import 'package:cookbook/components/form_error.dart';
import 'package:cookbook/size_config.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'components/custom_icon.dart';

class CompleteProfile extends StatelessWidget {
  static String name = "完善资料";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Complete Profile", style: headingStyle),
                Text("Complete ypur details or continue \nwith social media", textAlign: TextAlign.center),
                SizedBox(height: getProportionateScreenHeight(30)),
                ProfileForm(),
                SizedBox(height: getProportionateScreenHeight(30)),
                Text("By continuing ypur confirm that you agree \nwith our Term and Condition", textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileForm extends StatefulWidget {
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  String firstName, lastname, phone, address;
  List<String> errors = [];

  final _formKey = GlobalKey<FormState>();
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
          TextFormField(
            onSaved: (newValue) {
              return firstName = newValue;
            },
            decoration: InputDecoration(
              hintText: "Enter your first name",
              labelText: "First Name",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomIcon(
                img: "assets/icons/User.svg",
              ),
            ),
            validator: (value) {
              if (value.isEmpty) {
                addError(jNameNullError);

                return jNameNullError;
              }
              return null;
            },
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(jNameNullError);
              }
              return null;
            },
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          TextFormField(
            onSaved: (newValue) {
              return lastname = newValue;
            },
            decoration: InputDecoration(
              hintText: "Enter your last name",
              labelText: "Last Name",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomIcon(
                img: "assets/icons/User.svg",
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          TextFormField(
            keyboardType: TextInputType.number,
            onSaved: (newValue) {
              return phone = newValue;
            },
            decoration: InputDecoration(
              hintText: "Enter your phone number",
              labelText: "Phone",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomIcon(
                img: "assets/icons/Phone.svg",
              ),
            ),
            validator: (value) {
              if (value.isEmpty) {
                addError(jPhoneNumberNullError);

                return "";
              }
              return null;
            },
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(jPhoneNumberNullError);
              }
              return null;
            },
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          TextFormField(
            onSaved: (newValue) {
              return address = newValue;
            },
            decoration: InputDecoration(
              hintText: "Enter your address",
              labelText: "Address",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomIcon(
                img: "assets/icons/Location\ point.svg",
              ),
            ),
            validator: (value) {
              if (value.isEmpty) {
                addError(jAddressNullError);

                return "";
              }
              return null;
            },
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(jAddressNullError);
              }
              return null;
            },
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultBtn(
            text: "Continue",
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                Navigator.pushNamed(context, "/opt_screen");
              }
            },
          ),
        ],
      ),
    );
  }
}
