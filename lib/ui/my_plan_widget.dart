import 'package:flutter/material.dart';
import 'package:flutter_zjy/common/common.dart';
import 'package:flutter_zjy/data/api/api_services.dart';
import 'package:flutter_zjy/data/model/our_plans_model.dart';
import 'package:flutter_zjy/utils/sp_util.dart';
import 'package:flutter_zjy/widgets/refresh_helper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyPlanWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyPlanWidgetState();
  }
}

class MyPlanWidgetState extends State<MyPlanWidget> {
  List<OurPlansDataPlan> _plansList = new List();
  var _page = 1;

  var _userID = SPUtil.getInt(Constants.ID_KEY);

  /// listview 控制器
  ScrollController _scrollController = new ScrollController();
  RefreshController _refreshController =
      new RefreshController(initialRefresh: true);

  Future getPlansList() async {
    _page = 1;
    apiService.getOurProductList((OurPlansModel data) {
      if (data.code == Constants.STATUS_SUCCESS) {
        _plansList.clear();
        setState(() {
          _plansList.addAll(data.data.plans);
          _refreshController.refreshCompleted(resetFooterState: true);
        });
      }
    }, page: _page, id: _userID);
  }

  Future getMorePlansList() async {
    _page++;
    apiService.getOurProductList((OurPlansModel data) {
      if (data.code == Constants.STATUS_SUCCESS) {
        setState(() {
          _plansList.addAll(data.data.plans);
          _refreshController.loadComplete();
        });
      }
    }, page: _page, id: _userID);
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
                  _plansList[index].price.toString(),
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
                itemCount: _plansList[index].items.length,
                itemExtent: 100.0,
                itemBuilder: (BuildContext context, int i) {
                  String url = _plansList[index].items[i].skuImg != null
                      ? "https://img14.360buyimg.com/n1/" +
                          _plansList[index].items[i].skuImg
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
                DateTime.fromMillisecondsSinceEpoch(_plansList[index].time)
                    .toString(),
                style: TextStyle(fontSize: 10.0),
              ),
            ],
          ),
          Divider(height: 1)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("我的配制单"),
      ),
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
