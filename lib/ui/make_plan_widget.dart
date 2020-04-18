import 'package:flutter/material.dart';
import 'package:flutter_zjy/common/common.dart';
import 'package:flutter_zjy/common/router.dart';
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
  String _key = "";
  int _index = -1;
  List<ProductsData> _productImageList = new List(12);

  TextEditingController _textEditingController = new TextEditingController();

  /// listview 控制器
  ScrollController _scrollController = new ScrollController();

  RefreshController _refreshController =
      new RefreshController(initialRefresh: true);

  final _icons = [
    "assets/images/cpu.jpg",
    "assets/images/zhuban.jpeg",
    "assets/images/yingpan.jpg",
    "assets/images/neicuntiao.jpg",
    "assets/images/xianka.jpg",
    "assets/images/dianyuan.jpg",
    "assets/images/sanreqi.jpg",
    "assets/images/fengshan.jpg",
    "assets/images/xianshiqi.jpg",
    "assets/images/jianpan.jpg",
    "assets/images/shubiao.jpg",
    "assets/images/jixiang.jpg"
  ];

  final _tags = [
    "cpu",
    "主板",
    "硬盘",
    "内存条",
    "显卡",
    "电源",
    "散热",
    "风扇",
    "显示器",
    "键盘",
    "鼠标",
    "机箱"
  ];

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
    }, key: _key);
  }

  Future getMoreProductList() async {
    _page++;
    apiService.getProductList((ProductsModel data) {
      if (data.code == Constants.STATUS_SUCCESS) {
        setState(() {
          _productList.addAll(data.data);
          _refreshController.loadComplete();
        });
      }
    }, size: 10, page: _page, key: _key);
  }

  ImageProvider getImage(int index) {
    if (_productImageList[index] != null &&
        _productImageList[index].materialURL.length > 0) {
      return NetworkImage(_productImageList[index].materialURL);
    }
    return AssetImage(_icons[index]);
  }

  Widget itemView(BuildContext context, int index) {
    String s = _productList[index].inOrderCount30Days == null
        ? "0"
        : _productList[index].inOrderCount30Days.toString();
    return Container(
      height: 100.0,
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Image(
              height: 60.0,
              width: 60.0,
              image: NetworkImage(_productList[index].materialURL),
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        _productList[index].skuName,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 11.0,
                        ),
                      ),
                    ),
                    Flex(direction: Axis.horizontal, children: <Widget>[
                      Image(
                        image: AssetImage("assets/images/jingdong.jpg"),
                        height: 10.0,
                        width: 10.0,
                      ),
                      Text(
                        "￥" + _productList[index].price.toString(),
                        style: TextStyle(fontSize: 14.0, color: Colors.red),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Text(
                        "月销量：" + s,
                        style: TextStyle(fontSize: 10.0),
                      ),
                    ]),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 3.0),
                      child: Flex(
                        direction: Axis.horizontal,
                        children: <Widget>[
                          Text(
                            _productList[index].shopName,
                            style: TextStyle(fontSize: 10.0),
                          ),
                        ],
                      ),
                    ),
                    Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Spacer(
                          flex: 1,
                        ),
                        Container(
                          height: 15.0,
                          child: FlatButton(
                            color: Colors.blue,
                            highlightColor: Colors.blue[700],
                            colorBrightness: Brightness.dark,
                            splashColor: Colors.grey,
                            child: Text(
                              "加入配置单",
                              style: TextStyle(fontSize: 10.0),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            onPressed: () {
                              if (_index > -1) {
                                _productImageList[_index] = _productList[index];
                                setState(() {});
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    Divider(height: 1),
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
            controller: _textEditingController,
            style: TextStyle(fontSize: 13.0),
            textInputAction: TextInputAction.none,
            decoration: InputDecoration(hintText: "i5 9400f"),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _key = _textEditingController.text;
              getProductList();
            },
          ),
        ],
      ),
      body: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10.0),
            width: 70.0,
            child: ListView.separated(
              itemCount: 13,
              separatorBuilder: (BuildContext context, int index) {
                return Divider(color: Colors.blue);
              },
              itemBuilder: (BuildContext context, int index) {
                if (index == 12) {
                  return FlatButton(
                    color: Colors.blue,
                    highlightColor: Colors.blue[700],
                    colorBrightness: Brightness.dark,
                    splashColor: Colors.grey,
                    child: Text(
                      "完成",
                      style: TextStyle(fontSize: 11.0),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, RouterName.create_plan,
                          arguments: _productImageList);
                    },
                  );
                }

                Color color = Colors.white;
                if (index == _index) {
                  color = Colors.white10;
                }

                return InkWell(
                  onTap: () {
                    _index = index;
                    _key = _tags[index];
                    getProductList();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    color: color,
                    child: Image(
                      height: 30.0,
                      width: 30.0,
                      image: getImage(index),
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
              header: WaterDropHeader(),
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
