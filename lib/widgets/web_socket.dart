import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocket extends StatefulWidget {
  static String name = "Socket 测试";

  final WebSocketChannel channel = IOWebSocketChannel.connect('ws://echo.websocket.org');
  final String title;

  WebSocket({Key key, this.title}) : super(key: key);

  @override
  _WebSocketState createState() => _WebSocketState();
}

class _WebSocketState extends State<WebSocket> {
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    widget.channel.sink.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'send a message'),
              ),
            ),
            StreamBuilder(
              stream: widget.channel.stream,
              builder: (context, snapshot) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controller.text.isNotEmpty) {
            widget.channel.sink.add(_controller.text);
            _controller.text = '';
          }
        },
        tooltip: "Send message",
        child: Icon(Icons.send),
      ),
    );
  }
}
