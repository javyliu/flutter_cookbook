import 'package:cookbook/widgets/ex_sqflite.dart';
import 'package:cookbook/widgets/fetch_data.dart';
import 'package:cookbook/widgets/float_app_bar.dart';
import 'package:cookbook/widgets/form_validation.dart';
import 'package:cookbook/widgets/horizontal_list.dart';
import 'package:cookbook/widgets/photo_list.dart';
import 'package:cookbook/widgets/send_data.dart';
import 'package:cookbook/widgets/swipe_dismiss.dart';
import 'package:cookbook/widgets/todo_list.dart';
import 'package:cookbook/widgets/update_data.dart';
import 'package:cookbook/widgets/web_socket.dart';
import 'package:flutter/material.dart';

import '../widgets/menu_list.dart';

import '../widgets/animated_container.dart';
import '../widgets/page_route_transition.dart';
import '../widgets/physics_simulation.dart';
import '../widgets/fade_widget.dart';
import '../widgets/orientation.dart';

final todos = List<Todo>.generate(20, (index) => Todo('Todo $index', 'A description of what needs to be done for Todo $index'));

final List<Map> oriRoutes = [
  {"title": "菜单", "path": "/", "fun": (context) => MenuList()},
  {"title": "容器动画", "path": "/animated_container", "fun": (context) => AnimatedContainerApp()},
  {"title": "页面切换动画", "path": "/page_route_transition", "fun": (context) => PageRouteTransition()},
  {"title": "拖动动画", "path": "/physics_card_demo", "fun": (context) => PhysicsCardDragDemo()},
  {"title": "渐隐动画", "path": "/fade_widget", "fun": (context) => FadeWidget()},
  {"title": TOrientation.name, "path": "/orientation", "fun": (context) => TOrientation()},
  {"title": FormValidation.name, "path": "/form_validation", "fun": (context) => FormValidation()},
  {"title": SwipeDismiss.name, "path": "/swipe_dissmiss", "fun": (context) => SwipeDismiss()},
  {"title": FloatAppBar.name, "path": "/float_app_bar", "fun": (context) => FloatAppBar()},
  {"title": HorizontalList.name, "path": "/horizontal_list", "fun": (context) => HorizontalList()},
  {"title": TodoList.name, "path": "/todo_list", "fun": (context) => TodoList(todos: todos)},
  {"title": AlbumDetail.name, "path": "/album_detail", "fun": (context) => AlbumDetail()},
  {"title": PhotoList.name, "path": "/photo_list", "fun": (context) => PhotoList()},
  {"title": SendData.name, "path": "/send_data", "fun": (context) => SendData()},
  {"title": UpdateData.name, "path": "/update_data", "fun": (context) => UpdateData()},
  {"title": WebSocket.name, "path": "/web_socket", "fun": (context) => WebSocket(title: "聊天websocket测试")},
  {"title": ExSqflite.name, "path": "/ex_sqflite", "fun": (context) => ExSqflite()},
];

Map<String, WidgetBuilder> routes() {
  Map<String, WidgetBuilder> map = {};
  for (var item in oriRoutes) {
    map[item["path"]] = item["fun"];
  }
  return map;
}
