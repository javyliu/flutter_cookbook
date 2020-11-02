import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class MenuList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cook Book"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: oriRoutes.map((element) {
              return FlatButton(
                child: Text(element["title"]),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: element["fun"])),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
