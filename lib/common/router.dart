import 'package:flutter/material.dart';
import 'package:flutter_zjy/ui/about_widget.dart';
import 'package:flutter_zjy/ui/home_widget.dart';
import 'package:flutter_zjy/ui/login_widget.dart';
import 'package:flutter_zjy/ui/main_widget.dart';
import 'package:flutter_zjy/ui/userinfo_widget.dart';
import 'package:flutter_zjy/ui/webview_widget.dart';

/// 存放路由的配置
class RouterName {
  static const String login = 'login';
  static const String register = 'register';
  static const String home = 'home';
  static const String web_view = 'web_view';
  static const String about = 'about';
  static const String user_info = 'user_info';
}

class Router {
  static Map<String, WidgetBuilder> generateRoute() {
    Map<String, WidgetBuilder> routes = {
      RouterName.home: (context) => new MainWidget(),
      RouterName.web_view: (context) => new WebViewWidget(),
      RouterName.about: (context) => new AboutWidget(),
      RouterName.login: (context) => new LoginWidget(),
      RouterName.user_info: (context) => new UserInfoWidget(),
    };
    return routes;
  }
}
