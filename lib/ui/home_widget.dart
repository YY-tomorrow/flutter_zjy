import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zjy/common/router.dart';
import 'package:flutter_zjy/data/model/news_model.dart';
import 'package:flutter_zjy/common/common.dart';
import 'package:flutter_zjy/data/api/api_services.dart';
import 'package:flutter_zjy/widgets/refresh_helper.dart';
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
      new RefreshController(initialRefresh: true);

  Future getNewsList() async {
    _page = 1;
    apiService.getNewsList((NewsModel data) {
      if (data.code == Constants.STATUS_SUCCESS) {
        _newsList.clear();
        _refreshController.refreshCompleted(resetFooterState: true);
        setState(() {
          _newsList.addAll(data.data.data);
        });
      }
    });
  }

  Future getMoreNewsList() async {
    _page++;
    apiService.getNewsList((NewsModel data) {
      if (data.code == Constants.STATUS_SUCCESS) {
        _refreshController.loadComplete();
        setState(() {
          _newsList.addAll(data.data.data);
        });
      }
    }, size: 10, page: _page);
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
  }

  Widget itemView(BuildContext context, int index) {
    if (_newsList[index].img == null) {
      _newsList[index].img = "https://www.zujiying.top/demo.jpg";
    }

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouterName.web_view,
            arguments: _newsList[index].html);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
        height: 80.0,
        alignment: Alignment.centerLeft,
        color: Colors.transparent,
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Expanded(
                flex: 1,
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
                            maxLines: 2,
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
                )),
            Divider(height: 5)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(top: 25.0),
      child: SmartRefresher(
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
    ));
  }
}
