import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  static String name = "横版列表";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(HorizontalList.name),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: 160,
                    color: Colors.red,
                  ),
                  Container(
                    width: 160,
                    color: Colors.blue,
                  ),
                  Container(
                    width: 160,
                    color: Colors.green,
                  ),
                  Container(
                    width: 160,
                    color: Colors.amber,
                  ),
                  Container(
                    width: 160,
                    color: Colors.black45,
                  ),
                  Container(
                    width: 160,
                    color: Colors.blueGrey,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 500,
                color: Colors.white,
                child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(
                    100,
                    (index) => Center(child: Text("Item $index", style: Theme.of(context).textTheme.headline5)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
