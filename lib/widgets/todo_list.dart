import 'dart:developer';

import 'package:flutter/material.dart';

class TodoList extends StatelessWidget {
  static String name = "要做事列表";

  final List<Todo> todos;

  TodoList({Key key, @required this.todos}) : super(key: key) {
    log("---todo list constructor");
  }

  @override
  Widget build(BuildContext context) {
    log("----todo list build");

    return Scaffold(
      appBar: AppBar(
        title: Text(
          TodoList.name,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          log("---list view item builder");
          return ListTile(
            title: Text(todos[index].title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Detail(), settings: RouteSettings(arguments: todos[index])),
              );

              ///使用路由传参，也可以用构造函数传参，个人喜欢第二种
            },
          );
        },
        itemCount: todos.length,
      ),
    );
  }
}

class Detail extends StatelessWidget {
  // Detail({Key key, @required this.todo}) : super(key: key) {
  //   log("---todo detail contructor");
  // }

  @override
  Widget build(BuildContext context) {
    final Todo todo = ModalRoute.of(context).settings.arguments;
    log("---- detail builder ${todo.title}");

    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Text(todo.description),
      ),
    );
  }
}

class Todo {
  final String title;
  final String description;

  Todo(this.title, this.description);
}
