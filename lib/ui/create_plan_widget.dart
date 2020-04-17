import 'package:flutter/material.dart';
import 'package:flutter_zjy/common/common.dart';
import 'package:flutter_zjy/data/api/api_services.dart';
import 'package:flutter_zjy/data/model/products_model.dart';
import 'package:flutter_zjy/data/model/empty_response_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreatePlanWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CreatePlanWidgetState();
  }
}

class CreatePlanWidgetState extends State<CreatePlanWidget> {
  List<ProductsData> _productList = new List();
  List<ProductsData> data = new List();
  List<int> sku = new List();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  Future createPlan() async {
    var title = _titleController.toString();
    var content = _contentController.toString();
    var tag = "";
    var type = "plan";

    apiService.createPlan((EmptyResponseModel data) {
      if (data.code == Constants.STATUS_SUCCESS) {
        Fluttertoast.showToast(
            msg: "创建成功",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            // 消息框弹出的位置
            timeInSecForIos: 1,
            // 消息框持续的时间（目前的版本只有ios有效）
            backgroundColor: Colors.black45,
            textColor: Colors.white,
            fontSize: 13.0);
      }
    }, title, content, tag, type, sku);
  }

  Widget itemView(BuildContext context, int index) {
    String s = _productList[index].inOrderCount30Days == null
        ? "0"
        : _productList[index].inOrderCount30Days.toString();
    return Container(
      height: 80.0,
      child: Flex(direction: Axis.horizontal, children: <Widget>[
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
                  Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
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
                      Spacer(
                        flex: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ))
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;

    for (var i = 0; i < data.length; i++) {
      if (data[i] != null) {
        _productList.add(data[i]);
        sku.add(data[i].skuID);
      }
    }

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("发表内容"),
        actions: <Widget>[
          FlatButton(child: Text("完成"), onPressed: () => createPlan()),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: _titleController,
                maxLength: 20,
                maxLines: 1,
                decoration: InputDecoration.collapsed(hintText: "先来个标题"),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: _contentController,
                maxLength: 300,
                maxLines: 5,
                decoration: InputDecoration.collapsed(hintText: "这一刻的想法....."),
              ),
            ),
            Divider(height: 1),
            Expanded(
                flex: 1,
                child: ListView.separated(
                    itemBuilder: itemView,
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(color: Colors.black12);
                    },
                    itemCount: _productList.length))
          ],
        ),
      ),
    );
  }
}
