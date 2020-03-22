import 'package:flutter/material.dart';

class MakePlanWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MakePlanWidgetState();
}

class MakePlanWidgetState extends State<MakePlanWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, 30.0, 16.0, 10.0),
            constraints: BoxConstraints.tightFor(height: 80.0),
            //卡片大小
            decoration: BoxDecoration(
                //背景装饰
                gradient: RadialGradient(
                    //背景径向渐变
                    colors: [Colors.blue, Colors.lightBlue],
                    center: Alignment.topLeft,
                    radius: .9),
                boxShadow: [
                  //卡片阴影
                  BoxShadow(
                      color: Colors.black54,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 4.0)
                ]),
            alignment: Alignment.centerLeft,
            child: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
