import 'package:flutter/material.dart';
import 'package:flutter_zjy/common/common.dart';
import 'package:flutter_zjy/data/api/api_services.dart';
import 'package:flutter_zjy/widgets/refresh_helper.dart';
import 'package:flutter_zjy/data/model/products_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MakePlanWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MakePlanWidgetState();
}

class MakePlanWidgetState extends State<MakePlanWidget> {
  List<ProductsData> _productList = new List();

  int _page = 1;

  /// listview 控制器
  ScrollController _scrollController = new ScrollController();

  RefreshController _refreshController =
      new RefreshController(initialRefresh: true);

  Future getProductList() async {
    _page = 1;
    apiService.getProductList((ProductsModel data) {
      if (data.code == Constants.STATUS_SUCCESS) {
        _productList.clear();
        _refreshController.refreshCompleted(resetFooterState: true);
        setState(() {
          _productList.addAll(data.data);
        });
      }
    });
  }

  Future getMoreProductList() async {
    _page++;
    apiService.getProductList((ProductsModel data) {
      if (data.code == Constants.STATUS_SUCCESS) {
        _refreshController.loadComplete();
        setState(() {
          _productList.addAll(data.data);
        });
      }
    }, size: 10, page: _page);
  }

  Widget itemView(BuildContext context, int index) {
    return Container(
      height: 80.0,
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Image(
              height: 50.0,
              width: 50.0,
              image: NetworkImage(_productList[index].materialURL),
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        _productList[index].skuName,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 11.0,
                        ),
                      ),
                    ),
                    Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Text(
                          _productList[index].shopName,
                          style: TextStyle(fontSize: 10.0),
                        )
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0),
          alignment: Alignment.centerLeft,
          color: Colors.white,
          height: 35.0,
          child: TextField(
            style: TextStyle(fontSize: 13.0),
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(hintText: "用户名或邮箱"),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Container(
            width: 100.0,
            child: ListView.separated(
              itemCount: 10,
              separatorBuilder: (BuildContext context, int index) {
                return Divider(color: Colors.blue);
              },
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                    color: Colors.white12,
                    padding: EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 5.0),
                    child: Text(
                      "关于",
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: MaterialClassicHeader(),
              footer: RefreshFooter(),
              controller: _refreshController,
              onRefresh: getProductList,
              onLoading: getMoreProductList,
              child: ListView.builder(
                itemBuilder: itemView,
                physics: new AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                itemCount: _productList.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}
