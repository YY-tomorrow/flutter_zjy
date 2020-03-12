import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zjy/common/router.dart';
import 'package:flutter_zjy/data/api/apis.dart';
import 'package:flutter_zjy/data/model/news_model.dart';
import 'package:flutter_zjy/common/common.dart';
import 'package:flutter_zjy/data/api/api_services.dart';
import 'package:flutter_zjy/generated/json/news_model_helper.dart';
import 'package:flutter_zjy/widgets/refresh_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 首页
class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  List<NewsDataData> _newsList = new List();

  int _page = 1;

  /// listview 控制器
  ScrollController _scrollController = new ScrollController();

  RefreshController _refreshController =
      new RefreshController(initialRefresh: false);

  Future getNewsList() async {
    apiService.getNewsList((NewsModel data) {
      if (data.code == Constants.STATUS_SUCCESS) {
        _page = 1;
        _newsList.clear();
        _newsList = data.data.data;
        setState(() {});
        _refreshController.loadComplete();
      }
    });
  }

  Future getMoreNewsList() async {
    _page++;
    apiService.getNewsList((NewsModel data) {
      if (data.code == Constants.STATUS_SUCCESS) {
        setState(() {
          _newsList.addAll(data.data.data);
        });
        _refreshController.loadComplete();
      }
    }, size: 20, page: _page);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewsList();
  }

  Widget itemView(BuildContext context, int index) {
    if (_newsList[index].img == null) {
      _newsList[index].img = "https://www.zujiying.top/demo.jpg";
    }

    return InkWell(
      onTap: () {
        Fluttertoast.showToast(
            msg: _newsList[index].html,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,  // 消息框弹出的位置
            timeInSecForIos: 1,  // 消息框持续的时间（目前的版本只有ios有效）
            backgroundColor: Colors.black45,
            textColor: Colors.white,
            fontSize: 13.0
        );

        Navigator.pushNamed(context, RouterName.web_view,arguments: _newsList[index].html);

      },
      child: Container(
        padding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
        height: 80.0,
        color: Colors.transparent,
        child: Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
              child: Image(
                image: NetworkImage(_newsList[index].img),
                height: 60.0,
                width: 80.0,
              ),
            ),
            Expanded(
                child: Column(
              children: <Widget>[
                Expanded(
                  child: Text(
                    _newsList[index].title,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ),
                Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Spacer(
                      flex: 1,
                    ),
                    Text(
                      _newsList[index].pubDate,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            )),
          ],
        ),
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
        onRefresh: getNewsList,
        onLoading: getMoreNewsList,
        child: ListView.builder(
          itemBuilder: itemView,
          physics: new AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          itemCount: _newsList.length,
        ),
      ),
    );
  }
}
