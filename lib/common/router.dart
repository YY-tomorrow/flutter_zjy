
import 'package:flutter/material.dart';
import 'package:flutter_zjy/ui/home_widget.dart';

/// 存放路由的配置
class RouterName {
  static const String splash = 'splash';
  static const String login = 'login';
  static const String register = 'register';
  static const String main = 'main';
  static const String home = 'home';
  static const String knowledge_tree = 'knowledge_tree';
  static const String navigation = 'navigation';
  static const String we_chat = 'we_chat';
  static const String project = 'project';
  static const String hot_word = 'hot_word';
  static const String hot_result = 'hot_result';
  static const String web_view = 'web_view';
  static const String todo = 'todo';
  static const String todo_add = 'todo_add';
}

class Router {
  static Map<String, WidgetBuilder> generateRoute() {
    Map<String, WidgetBuilder> routes = {
      RouterName.home: (context) => new HomeScreen(),
    };
    return routes;
  }
}
