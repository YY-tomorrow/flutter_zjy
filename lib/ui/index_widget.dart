import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zjy/ui/main_widget.dart';

class IndexWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return IndexWidgetState();
  }
}

class IndexWidgetState extends State<IndexWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushAndRemoveUntil(
          // pushAndRemoveUntil 返回到根路由
          /// builder(WidgetBuilder) 是一个WidgetBuilder类型的回调函数，它的作用是构建路由页面的具体内容，返回值是一个widget。我们通常要实现此回调，返回新路由的实例。
          ///  settings(RouteSettings) 包含路由的配置信息，如路由名称、是否初始路由（首页）。
          ///  maintainState：默认情况下，当入栈一个新路由时，原来的路由仍然会被保存在内存中，如果想在路由没用的时候释放其所占用的所有资源，可以设置maintainState为false。
          ///  fullscreenDialog表示新的路由页面是否是一个全屏的模态对话框，在iOS中，如果fullscreenDialog为true，新页面将会从屏幕底部滑入（而不是水平方向）
          new MaterialPageRoute(builder: (context) => MainWidget()),
          (route) => route == null);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        color: Colors.white,
        alignment: Alignment.center,
        //卡片大小
        child: Container(
          constraints: BoxConstraints.tightFor(width: 200.0, height: 250.0),
          child: Column(
            children: <Widget>[
              Image(image: AssetImage("assets/images/zujiying.jpeg")),
              Text(
                "组机营",
                style: TextStyle(color: Colors.blue, fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ));
  }
}
