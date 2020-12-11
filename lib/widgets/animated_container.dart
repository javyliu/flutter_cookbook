import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class AnimatedContainerApp extends StatefulWidget {
  @override
  _AnimatedContainerAppState createState() => _AnimatedContainerAppState();
}

class _AnimatedContainerAppState extends State<AnimatedContainerApp> {
  double _width = 50;
  double _height = 50;
  Color _color = Colors.green;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);
  GlobalKey _gkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedContainer Demo'),
      ),
      body: RepaintBoundary(
        key: _gkey,
        child: Center(
          child: AnimatedContainer(
            width: _width,
            height: _height,
            decoration: BoxDecoration(
              color: _color,
              borderRadius: _borderRadius,
            ),
            duration: Duration(seconds: 1),
            curve: Curves.bounceInOut,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: () async {
          setState(() {
            final random = Random();
            _width = random.nextInt(300).toDouble();
            _height = random.nextInt(300).toDouble();

            _color = Color.fromRGBO(random.nextInt(256), random.nextInt(256), random.nextInt(256), 1);
            _borderRadius = BorderRadius.circular(random.nextInt(100).toDouble());
          });

          ///把widget导出成图片
          ///todo: 如何存储到...
          RenderRepaintBoundary boundary = _gkey.currentContext.findRenderObject();
          final image = await boundary.toImage();
          ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
          Uint8List pngBytes = byteData.buffer.asUint8List();

          showDialog(
            context: context,
            barrierDismissible: true,
            barrierColor: Colors.amber,
            builder: (context) {
              return AlertDialog(
                title: Text('memory image'),
                content: Image.memory(pngBytes),
                actions: [
                  FlatButton(onPressed: () => Navigator.of(context).pop(), child: const Text("Cancel")),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
