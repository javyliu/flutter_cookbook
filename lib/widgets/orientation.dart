import 'package:flutter/material.dart';

class TOrientation extends StatelessWidget {
  static String name = "横竖屏测试";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TOrientation.name),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return GridView.count(
            crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
            children: List.generate(100, (index) {
              return Container(
                height: 10,
                child: Center(
                  child: Text("item $index", style: Theme.of(context).textTheme.headline4),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
