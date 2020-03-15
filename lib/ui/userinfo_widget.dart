import 'package:flutter/material.dart';
import 'package:flutter_zjy/common/common.dart';

class UserInfoWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UserInfoWidgetState();
  }
}

class UserInfoWidgetState extends State<UserInfoWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text(AppBarName.user_info)),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text("$index"),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(color: Colors.blue);
          },
          itemCount: 10),
    );
  }
}
