import 'dart:convert';
import 'dart:developer';

import 'package:cookbook/models/album.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response = await http.get('https://jsonplaceholder.typicode.com/albums/1');
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    log("-------fetch album response: $data");

    return Album.fromJson(data);
  } else {
    throw Exception("Failed to load album");
  }
}

Future<Album> updateAlbum(String title) async {
  final http.Response response = await http.put(
    'https://jsonplaceholder.typicode.com/albums/1',
    headers: <String, String>{'Content-Type': 'application/json;charset=UTF-8'},
    body: jsonEncode(
      <String, String>{'title': title},
    ),
  );

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    log("----update album response: $data");

    return Album.fromJson(data);
  } else {
    throw Exception('Failed to update Album');
  }
}

class UpdateData extends StatefulWidget {
  static String name = "更新数据";
  @override
  _UpdateDataState createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  final TextEditingController _controller = TextEditingController();
  Future<Album> _futureAlbum;

  @override
  void initState() {
    super.initState();
    _futureAlbum = fetchAlbum();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(UpdateData.name),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        child: FutureBuilder<Album>(
          future: _futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Text(snapshot.data.title),
                    TextField(
                      controller: _controller,
                      decoration: InputDecoration(hintText: 'Enter Title'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _futureAlbum = updateAlbum(_controller.text);
                        });
                      },
                      child: Text("update data"),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
