import 'package:cookbook/screens/home_screen.dart';
import 'package:cookbook/screens/opt_screen.dart';
import 'package:flutter/material.dart' show WidgetBuilder;

import '../extension/exts.dart';
import '../main.dart';
import '../screens/complete_profile.dart';
import '../screens/forgot_password.dart';
import '../screens/login_success.dart';
import '../screens/sign_in.dart';
import '../screens/sign_up.dart';
import '../screens/splash_screen.dart';
import '../widgets/animated_container.dart';
import '../widgets/ex_charts.dart';
import '../widgets/ex_data_table.dart';
import '../widgets/ex_file.dart';
import '../widgets/ex_image_picker.dart';
import '../widgets/ex_qr_code_scanner.dart';
import '../widgets/ex_shared_preference.dart';
import '../widgets/ex_sqflite.dart';
import '../widgets/ex_video.dart';
import '../widgets/fade_widget.dart';
import '../widgets/fetch_data.dart';
import '../widgets/float_app_bar.dart';
import '../widgets/form_validation.dart';
import '../widgets/horizontal_list.dart';
import '../widgets/menu_list.dart';
import '../widgets/orientation.dart';
import '../widgets/page_route_transition.dart';
import '../widgets/photo_list.dart';
import '../widgets/physics_simulation.dart';
import '../widgets/send_data.dart';
import '../widgets/swipe_dismiss.dart';
import '../widgets/todo_list.dart';
import '../widgets/update_data.dart';
import '../widgets/web_socket.dart';

final todos = List<Todo>.generate(20, (index) => Todo('Todo $index', 'A description of what needs to be done for Todo $index'));

final List<Map> oriRoutes = [
  // {"title": "splashs", "path": "/", "fun": (context) => MyApp()},
  {"title": "splash1", "path": "/", "fun": (context) => SplaScrs()},
  {"title": "菜单", "path": "/menulist", "fun": (context) => MenuList()},
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
  {"title": ExFile.name, "path": "/ex_file", "fun": (context) => ExFile(storage: CounterStorage())},
  {"title": ExSharedPreference.name, "path": "/ex_shared_pref", "fun": (context) => ExSharedPreference(title: "test shared preference")},
  {"title": ExVideo.name, "path": "/ex_video", "fun": (context) => ExVideo()},
  {"title": ExCharts.name, "path": "/ex_charts", "fun": (context) => ExCharts()},
  {"title": ExDataTable.name, "path": "/ex_data_table", "fun": (context) => ExDataTable()},
  {"title": ExQrView.name, "path": "/ex_qr_view", "fun": (context) => ExQrView()},
  {"title": ExImagePicker.name, "path": "/ex_image_picker", "fun": (context) => ExImagePicker()},
  {"title": SplashScreen.name, "path": (SplashScreen).toString().underscore(), "fun": (context) => SplashScreen()},
  {"title": SignIn.name, "path": (SignIn).toString().underscore(), "fun": (context) => SignIn()},
  {"title": ForgotPassword.name, "path": (ForgotPassword).toString().underscore(), "fun": (context) => ForgotPassword()},
  {"title": LoginSuccess.name, "path": (LoginSuccess).toString().underscore(), "fun": (context) => LoginSuccess()},
  {"title": SignUp.name, "path": (SignUp).toString().underscore(), "fun": (context) => SignUp()},
  {"title": CompleteProfile.name, "path": (CompleteProfile).toString().underscore(), "fun": (context) => CompleteProfile()},
  {"title": OptScreen.name, "path": (OptScreen).toString().underscore(), "fun": (context) => OptScreen()},
  {"title": HomeScreen.name, "path": (HomeScreen).toString().underscore(), "fun": (context) => HomeScreen()},
];

Map<String, WidgetBuilder> routes() {
  Map<String, WidgetBuilder> map = {};
  for (var item in oriRoutes) {
    map[item["path"]] = item["fun"];
  }
  return map;
}
