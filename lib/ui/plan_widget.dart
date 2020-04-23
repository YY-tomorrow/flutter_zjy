import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zjy/common/common.dart';
import 'package:flutter_zjy/common/router.dart';
import 'package:flutter_zjy/data/api/api_services.dart';
import 'package:flutter_zjy/data/model/our_plans_model.dart';
import 'package:flutter_zjy/widget/plan_item.dart';
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
  List<OurPlansDataPlan> _plansList = new List();
  var _page = 1;

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
    }, page: _page);
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
    }, page: _page);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("方案"),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: RefreshFooter(),
        controller: _refreshController,
        onRefresh: getPlansList,
        onLoading: getMorePlansList,
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              PlanItem(_plansList[index]),
          physics: new AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          itemCount: _plansList.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, RouterName.make_plan),
        child: Icon(Icons.add),
      ),
    );
  }
}
