import 'package:flutter/material.dart';

class FormValidation extends StatelessWidget {
  static String name = "表单验证";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FormValidation.name),
      ),
      body: MyForm(),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  //用于控制谁获得焦点，如果多个该怎么办么？

  final FocusNode myFodusNode = FocusNode();
  @override
  void dispose() {
    myController.dispose();
    myFodusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    myController.addListener(_printLatestValue);
  }

  _printLatestValue() {
    print("Second text field: ${myController.text} ");
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: "Enter your name",
              // border: InputBorder.none,
            ),
            validator: (value) {
              if (value.isEmpty) {
                return "Please enter some text";
              }
              return null;
            },
            focusNode: myFodusNode,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: myController,
            // onChanged: (value) {
            //   print("First text field: $value");
            // },
          ),
          TextField(
            decoration: InputDecoration(labelText: "密码"),

            // autofocus: true,
          ),
          TextField(
            decoration: InputDecoration(labelText: "重复密码"),
            // autofocus: true,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text("Processing Data...")));
                }
              },
              child: Text("Submit"),
            ),
          ),
          FlatButton(
            onPressed: () {
              // myFodusNode.requestFocus();
              myFodusNode.nextFocus();
              return showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(myController.text),
                  );
                },
              );
            },
            child: Text("显示输入框内容"),
          ),
          InkWell(
            onTap: () {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Tap"),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(12.0),
              child: Text("使用InkWell显示点击水波纹效果"),
            ),
          )
        ],
      ),
    );
  }
}
