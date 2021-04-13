import 'dart:convert';
import 'dart:developer';

import 'package:cookbook/models/album.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  log("--fetch album");

  final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/albums/1"));
  log("---fetch album response: ${jsonDecode(response.body)}");

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to load Album");
  }
}

Future<Album> deleteAlbum(String id) async {
  log("---------id is: $id");

  final response = await http.delete(
    Uri.parse("https://jsonplaceholder.typicode.com/albums/$id"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  log("---fetch album response: ${jsonDecode(response.body)}");
  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to delete album');
  }
}

class AlbumDetail extends StatefulWidget {
  static String name = "获取网络数据";

  @override
  _AlbumDetailState createState() => _AlbumDetailState();
}

class _AlbumDetailState extends State<AlbumDetail> {
  Future<Album> futureAlbum;

  @override
  void initState() {
    log("------init state");

    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    log("----album detail build");

    return Scaffold(
      appBar: AppBar(
        title: Text(AlbumDetail.name),
      ),
      body: Center(
        child: FutureBuilder<Album>(
          future: futureAlbum,
          builder: (context, snapshot) {
            log("-- future builder builder");

            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Text(snapshot.data?.title ?? 'Deleted'),
                    ElevatedButton(
                      child: Text("Delete Data"),
                      onPressed: () {
                        setState(() {
                          futureAlbum = deleteAlbum(snapshot.data.id.toString());
                        });
                      },
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
