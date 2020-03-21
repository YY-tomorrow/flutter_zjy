import 'package:flutter/material.dart';
import 'package:flutter_zjy/common/common.dart';

class AboutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text(AppBarName.about_us)),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("本项目为个人开发项目，但是会持续更新，期待对flutter感兴趣的开发者，或者对组装机有兴趣的朋友一起学习，交流，如有任何问题都可扫描二维码取得联系."),
            ),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Image(
                image: AssetImage("assets/images/about_me.jpg")
              ),
            ),
          ],
        ),
      ),
    );
  }
}
