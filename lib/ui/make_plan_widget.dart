import 'package:flutter/material.dart';
import 'package:flutter_zjy/widgets/search_bar.dart';

class MakePlanWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MakePlanWidgetState();
}

class MakePlanWidgetState extends State<MakePlanWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0),
          alignment: Alignment.centerLeft,
          color: Colors.white,
          height: 35.0,
          child: TextField(
            style: TextStyle(fontSize: 13.0),
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(hintText: "用户名或邮箱"),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Flex(
        direction: Axis.horizontal,
        children: <Widget>[

        ],
      ),
    );
  }
}
