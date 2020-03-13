import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zjy/common/router.dart';

class MyWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyWidgetState();
  }
}

class MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
          constraints: BoxConstraints.tightFor(height: 200.0),
          //卡片大小
          decoration: BoxDecoration(
              //背景装饰
              gradient: RadialGradient(
                  //背景径向渐变
                  colors: [Colors.red, Colors.orange],
                  center: Alignment.topLeft,
                  radius: .98),
              boxShadow: [
                //卡片阴影
                BoxShadow(
                    color: Colors.black54,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 4.0)
              ]),
          alignment: Alignment.center,
          //卡片内文字居中
          child: Text(
            //卡片文字
            "5.20", style: TextStyle(color: Colors.white, fontSize: 40.0),
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: 1,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(color: Colors.blue);
            },
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouterName.about,
                  );
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 5.0),
                  child: Text(
                    "关于",
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
