import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zjy/data/model/our_plans_model.dart';

class PlanItem extends StatelessWidget {
  final OurPlansDataPlan data;

  const PlanItem(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 130.0,
      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Container(
            height: 25.0,
            child: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Text(
                  data.title,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 13.0,
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                Text(
                  (data.price / 100).toString(),
                  style: TextStyle(fontSize: 12.0, color: Colors.deepOrange),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
                padding: EdgeInsets.all(1.0),
                scrollDirection: Axis.horizontal,
                itemCount: data.items.length,
                itemExtent: 80.0,
                itemBuilder: (BuildContext context, int i) {
                  String url = data.items[i].skuImg != null
                      ? "https://img14.360buyimg.com/n1/" + data.items[i].skuImg
                      : "https://www.zujiying.top/demo.jpg";
                  return Image(
                    image: NetworkImage(url),
                  );
                }),
          ),
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Spacer(
                flex: 1,
              ),
              Text(
                DateUtil.getDateStrByMs(data.time * 1000).toString(),
                style: TextStyle(fontSize: 10.0),
              ),
            ],
          ),
          Divider(height: 1)
        ],
      ),
    );
  }
}
