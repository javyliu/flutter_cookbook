import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/photo.dart';

List<Photo> parsePhotos(dynamic responseBody) {
  log("----parse photos");

  final parsed = responseBody;

  return parsed.map<Photo>((json) => Photo.fromJson(json.cast<String, dynamic>())).toList();
}

Future<List<Photo>> fetchPhotos(http.Client client) async {
  log("----fetch photos");

  final response = await client.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
  final body = jsonDecode(response.body);

  // log(body.toString());
  return compute(parsePhotos, body);
}

class PhotoList extends StatefulWidget {
  static String name = "获取列表数据";

  @override
  _PhotoListState createState() => _PhotoListState();
}

class _PhotoListState extends State<PhotoList> {
  @override
  Widget build(BuildContext context) {
    log("=== phtot list build");

    return Scaffold(
      appBar: AppBar(
        title: Text(PhotoList.name),
      ),
      body: FutureBuilder<List<Photo>>(
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          log("====Future builder ");

          if (snapshot.hasError) log("-----${snapshot.error}");

          return snapshot.hasData
              ? Photos(
                  photos: snapshot.data,
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class Photos extends StatelessWidget {
  final List<Photo> photos;

  const Photos({Key key, this.photos}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    log("====photos build");

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return Image.network(photos[index].thumbnailUrl);
      },
    );
  }
}
