import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zjy/data/api/apis.dart';
import 'package:flutter_zjy/data/model/news_model.dart';
import 'package:flutter_zjy/common/common.dart';
import 'package:flutter_zjy/data/api/api_services.dart';
import 'package:flutter_zjy/generated/json/news_model_helper.dart';
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

  String _cursor = "";

  Future getNewsList() async {
    apiService.getNewsList((NewsModel data) {
      if (data.code == Constants.STATUS_SUCCESS) {
        setState(() {
          _newsList.insertAll(_newsList.length, data.data.data);
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewsList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.separated(
      itemCount: _newsList.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(_newsList[index].title));
      },
      separatorBuilder: (context, index) => Divider(height: 1),
    );
  }
}
