import 'package:flutter/material.dart';
import 'package:flutter_zjy/ui/home_widget.dart';
import 'package:flutter_zjy/ui/main_widget.dart';
import 'package:flutter_zjy/ui/webview_widget.dart';

/// 存放路由的配置
class RouterName {
  static const String login = 'login';
  static const String register = 'register';
  static const String home = 'home';
  static const String web_view = 'web_view';
  static const String todo = 'todo';
}

class Router {
  static Map<String, WidgetBuilder> generateRoute() {
    Map<String, WidgetBuilder> routes = {
      RouterName.home: (context) => new MainWidget(),
      RouterName.web_view: (context) => new WebViewWidget(),
    };
    return routes;
  }
}
