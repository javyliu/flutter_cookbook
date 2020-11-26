import 'dart:ffi';

import 'package:flutter/material.dart';

class FloatAppBar extends StatelessWidget {
  static String name = "浮动导航";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(FloatAppBar.name),
              floating: true,
              flexibleSpace: Image.asset(
                "assets/images/movid.jpg",
                fit: BoxFit.fitWidth,
              ),
              expandedHeight: 200,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(
                  title: Text("Item #$index"),
                ),
                childCount: 1000,
              ),
            )
          ],
        ),
      ),
    );
  }
}
