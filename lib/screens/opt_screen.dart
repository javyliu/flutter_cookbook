import 'package:cookbook/components/default_btn.dart';
import 'package:cookbook/constants.dart';
import 'package:cookbook/size_config.dart';
import 'package:flutter/material.dart';

class OptScreen extends StatelessWidget {
  static String name = "Opt 验证";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.08),
                  Text("OPT Verification", style: headingStyle),
                  Text("We sent ypur code to +186009*** ", textAlign: TextAlign.center),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("This code will expired in "),
                      TweenAnimationBuilder(
                        tween: Tween(begin: 30.0, end: 0),
                        duration: Duration(seconds: 30),
                        builder: (context, value, child) => Text("00:${value.toInt()}", style: TextStyle(color: jPrimaryColor)),
                        onEnd: () {
                          print("-----time is end");
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.08),
                  OptForm(),
                  SizedBox(height: SizeConfig.screenHeight * 0.08),
                  GestureDetector(
                    child: Text("Resend OPT Code", style: TextStyle(decoration: TextDecoration.underline)),
                    onTap: () {
                      //need to resend opt code
                    },
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.03),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OptForm extends StatefulWidget {
  @override
  _OptFormState createState() => _OptFormState();
}

class _OptFormState extends State<OptForm> {
  FocusNode fn1;
  FocusNode fn2;
  FocusNode fn3;
  FocusNode fn4;

  @override
  void initState() {
    super.initState();
    fn1 = FocusNode();
    fn2 = FocusNode();
    fn3 = FocusNode();
    fn4 = FocusNode();
  }

  @override
  void dispose() {
    fn1.dispose();
    fn2.dispose();
    fn3.dispose();
    fn4.dispose();
    super.dispose();
  }

  void nextField({String value, FocusNode focusNode}) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  autofocus: true,
                  focusNode: fn1,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                  decoration: optInputDecoration,
                  onChanged: (value) {
                    nextField(value: value, focusNode: fn2);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  obscureText: true,
                  focusNode: fn2,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                  decoration: optInputDecoration,
                  onChanged: (value) {
                    nextField(value: value, focusNode: fn3);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: fn3,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                  decoration: optInputDecoration,
                  onChanged: (value) {
                    nextField(value: value, focusNode: fn4);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: fn4,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                  decoration: optInputDecoration,
                  onChanged: (value) {
                    fn4.unfocus();
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.3),
          DefaultBtn(
            text: "Continue",
            press: () {},
          )
        ],
      ),
    );
  }
}
