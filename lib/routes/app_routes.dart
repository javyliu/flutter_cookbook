import 'package:flutter/material.dart';

import '../widgets/menu_list.dart';

import '../widgets/animated_container.dart';
import '../widgets/page_route_transition.dart';
import '../widgets/physics_simulation.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (context) => MenuList(),
  '/animated_container_app': (context) => AnimatedContainerApp(),
  '/page_route_transition': (context) => PageRouteTransition(),
  '/physics_card_drag': (context) => PhysicsCardDragDemo(),
};
