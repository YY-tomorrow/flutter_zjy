import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WebViewWidgetState();
  }
}

class WebViewWidgetState extends State<WebViewWidget> {

  String _url;

  @override
  Widget build(BuildContext context) {

    _url = ModalRoute.of(context).settings.arguments;
    // TODO: implement build
    return WebviewScaffold(
      url: _url,
    );
  }
}
