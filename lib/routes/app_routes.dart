import 'package:flutter/material.dart';

import '../widgets/menu_list.dart';

import '../widgets/animated_container.dart';
import '../widgets/page_route_transition.dart';
import '../widgets/physics_simulation.dart';

final List<Map> oriRoutes = [
  {"title": "菜单", "path": "/", "fun": (context) => MenuList()},
  {"title": "容器动画", "path": "/animated_container", "fun": (context) => AnimatedContainerApp()},
  {"title": "页面切换动画", "path": "/page_route_transition", "fun": (context) => PageRouteTransition()},
  {"title": "拖动动画", "path": "/physics_card_demo", "fun": (context) => PhysicsCardDragDemo()},
];

Map<String, WidgetBuilder> routes() {
  Map<String, WidgetBuilder> map = {};
  for (var item in oriRoutes) {
    map[item["path"]] = item["fun"];
  }
  return map;
}
