import 'dart:developer';

import 'package:flutter/material.dart';

import '../routes/app_routes.dart';
import 'package:transparent_image/transparent_image.dart';
import '../extension/exts.dart';

class MenuList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final snackBar = SnackBar(content: Text("Yay! A SnackBar"));
    final _globalKey = GlobalKey<ScaffoldMessengerState>();
    var k = "sdf33i".to_i;
    var reg = RegExp(r'\d+');
    var u = reg.allMatches("232103kdf0000234234");
    var u1 = reg.stringMatch("skdfj");
    var k3 = [3, 4, 5].detect((element) => element > 8);
    log("====$k3");

    log("--${k.runtimeType} $k -------group(0): ${u.elementAt(1).group(0)}---groups:${u.elementAt(0).groups([0])}---u1: $u1");

    ///在Scaffold 中使用Scaffold.of(ctx) 来显示snackBar时，如提示“called with a context that does not contain a scaffold"
    ///表示当前并非scaffold的StatelessWidget类型子组件，所以需要把showSnackBar方法嵌入到一个stalesswidget 或statefulwidget组件中，或使用globalkey
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Cook Book"),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.add_alert),
              ),
              Tab(
                icon: Icon(Icons.directions_car),
              ),
              Tab(
                icon: Icon(Icons.directions_transit),
              ),
              Tab(
                icon: Icon(Icons.directions_bike),
              ),
            ],
          ),
        ),
        key: _globalKey,
        // body: DisSnackBar(snackBar: snackBar),
        body: TabBarView(
          children: [
            Center(
              child: ElevatedButton(
                child: Text("show snackbar"),
                onPressed: () => _globalKey.currentState.showSnackBar(snackBar),
              ),
            ),
            ListView(
              scrollDirection: Axis.vertical,
              children: [
                ListTile(
                  leading: Icon(Icons.map),
                  title: Icon(Icons.directions_car),
                ),
                ListTile(
                  leading: Icon(Icons.photo_album),
                  title: Text("Album"),
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text("Phone"),
                )
              ],
            ),
            Container(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    color: Colors.blue,
                    child: Text("container the height"),
                  ),
                  Container(
                    width: 160,
                    color: Colors.blue[300],
                  ),
                  Container(
                    width: 160,
                    color: Colors.blue[600],
                  )
                ],
              ),
            ),
            Column(
              children: [
                Icon(Icons.directions_bike),
                Image.network(
                  'https://picsum.photos/250?image=9',
                ),
                Stack(children: [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                  Center(
                    child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: 'https://picsum.photos/250?image=9'),
                  ),
                ]),
              ],
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Text("Drawer Header"),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
            ]..addAll(
                oriRoutes.map((el) {
                  return SizedBox(
                    height: 40,
                    child: ListTile(
                      title: Text(el["title"]),
                      onTap: () {
                        Navigator.pop(context);
                        return Navigator.pushNamed(context, el["path"], arguments: el["title"]);
                      },
                    ),
                  );
                }),
              ),
          ),
        ),
      ),
    );
  }
}

class DisSnackBar extends StatelessWidget {
  const DisSnackBar({
    Key key,
    @required this.snackBar,
  }) : super(key: key);

  final SnackBar snackBar;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(child: Text("显示 SnackBar"), onPressed: () => ScaffoldMessenger.of(context).showSnackBar(snackBar)),
    );
  }
}
