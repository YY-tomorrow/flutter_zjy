import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';

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
