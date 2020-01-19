import 'package:flutter/cupertino.dart';
import 'package:flutter/src/material/app_bar.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_zjy/ui/base_widget.dart';

class ReportCardWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ReportCardWidgetState();
  }
}

class ReportCardWidgetState extends State<ReportCardWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Image(
        image: NetworkImage("https://www.zujiying.top/demo.jpg"),
      ),
    );
  }
}
