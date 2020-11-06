import 'package:flutter/material.dart';

class SwipeDismiss extends StatefulWidget {
  static String name = "扫动删除";

  @override
  _SwipeDismissState createState() => _SwipeDismissState();
}

class _SwipeDismissState extends State<SwipeDismiss> {
  final items = List<String>.generate(20, (index) => "Item ${index + 1}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(SwipeDismiss.name),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Dismissible(
              child: ListTile(
                title: Text(item),
              ),
              key: Key(item),
              onDismissed: (direction) {
                setState(() {
                  items.removeAt(index);
                });
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text("$item is dismissed"),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              background: Container(
                color: Colors.red,
              ),
            );
          },
        ),
      ),
    );
  }
}
