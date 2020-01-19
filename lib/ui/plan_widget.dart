import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlanWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PlanWidgetState();
  }
}

class PlanWidgetState extends State<PlanWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(title: Text("index $index"));
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Colors.grey,
          );
        },
        itemCount: 20);
  }
}
