import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zjy/common/common.dart';
import 'package:flutter_zjy/data/api/api_services.dart';
import 'package:flutter_zjy/data/model/spider_plans_model.dart';
import 'package:flutter_zjy/widgets/refresh_helper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PlanWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PlanWidgetState();
  }
}

class PlanWidgetState extends State<PlanWidget> {
  List<SpiderPlansDataPlan> _plansList = new List();
  var _page = 1;

  /// listview 控制器
  ScrollController _scrollController = new ScrollController();

  RefreshController _refreshController =
      new RefreshController(initialRefresh: true);

  Future getPlansList() async {
    _page = 1;
    apiService.getPlansList((SpiderPlansModel data) {
      if (data.code == Constants.STATUS_SUCCESS) {
        _plansList.clear();
        _refreshController.refreshCompleted(resetFooterState: true);
        setState(() {
          _plansList.addAll(data.data.plans);
        });
      }
    }, page: _page);
  }

  Future getMorePlansList() async {
    _page++;
    apiService.getPlansList((SpiderPlansModel data) {
      if (data.code == Constants.STATUS_SUCCESS) {
        _refreshController.loadComplete();
        setState(() {
          _plansList.addAll(data.data.plans);
        });
      }
    }, page: _page);
  }

  Widget itemView(BuildContext context, int index) {
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
                  _plansList[index].title,
                  style: TextStyle(fontSize: 13.0),
                ),
                Spacer(
                  flex: 1,
                ),
                Text(
                  _plansList[index].price,
                  style: TextStyle(fontSize: 12.0, color: Colors.deepOrange),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
                padding: EdgeInsets.all(5.0),
                scrollDirection: Axis.horizontal,
                itemCount: _plansList[index].elements.length,
                itemExtent: 100.0,
                itemBuilder: (BuildContext context, int i) {
                  String url = _plansList[index].elements[i].image != null
                      ? _plansList[index].elements[i].image
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
                _plansList[index].time,
                style: TextStyle(fontSize: 10.0),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: MaterialClassicHeader(),
        footer: RefreshFooter(),
        controller: _refreshController,
        onRefresh: getPlansList,
        onLoading: getMorePlansList,
        child: ListView.builder(
          itemBuilder: itemView,
          physics: new AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          itemCount: _plansList.length,
        ),
      ),
    );
  }
}
