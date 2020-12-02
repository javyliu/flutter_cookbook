import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExSharedPreference extends StatefulWidget {
  static String name = '键值存储';
  final String title;

  const ExSharedPreference({Key key, this.title}) : super(key: key);

  @override
  _ExSharedPreferenceState createState() => _ExSharedPreferenceState();
}

class _ExSharedPreferenceState extends State<ExSharedPreference> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  ///加载数量，如是第一次则为0，该方法为异步方法，
  Future _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt("counter") ?? 0;
    });
  }

  void _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter++;
      prefs.setInt('counter', _counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ExSharedPreference.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("You have pushed the button this many times:"),
            Text(
              "$_counter",
              style: Theme.of(context).textTheme.headline4,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: "Increment",
        child: Icon(Icons.add),
      ),
    );
  }
}
