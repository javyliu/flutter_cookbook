import 'dart:convert';

import 'package:cookbook/models/album.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> createAlbum(String title) async {
  final http.Response response = await http.post(
    'https://jsonplaceholder.typicode.com/albums',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );

  if (response.statusCode == 201) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create album');
  }
}

class SendData extends StatefulWidget {
  static String name = "发送数据到服务器";

  @override
  _SendDataState createState() => _SendDataState();
}

class _SendDataState extends State<SendData> {
  final TextEditingController _titleCon = TextEditingController();
  Future<Album> _futureAlbum;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(SendData.name),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        child: buildChild(),
      ),
    );
  }

  Widget buildChild() {
    if (_futureAlbum == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _titleCon,
            decoration: InputDecoration(hintText: 'Enter Title'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _futureAlbum = createAlbum(_titleCon.text);
              });
            },
            child: Text("Create Data"),
          ),
        ],
      );
    } else {
      return FutureBuilder<Album>(
        future: _futureAlbum,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.title);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return CircularProgressIndicator();
        },
      );
    }
  }
}
