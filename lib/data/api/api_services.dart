import 'package:flutter_zjy/data/api/apis.dart';
import 'package:flutter_zjy/generated/json/news_model_helper.dart';
import 'package:flutter_zjy/data/model/news_model.dart';
import 'package:flutter_zjy/data/model/spider_plans_model.dart';
import 'package:flutter_zjy/generated/json/spider_plans_model_helper.dart';
import 'package:flutter_zjy/net/dio_manager.dart';

ApiService _apiService = new ApiService();

ApiService get apiService => _apiService;

class ApiService {
  // 首页获取新闻资讯
  void getNewsList(Function callback, {int size, page}) async {
    dio.get(Apis.NEWS_LIST,
        queryParameters: {"page_size": size, "current": page}).then((response) {
      callback(newsModelFromJson(new NewsModel(), response.data));
    });
  }

  // 爬虫获取方案列表
  void getPlansList(Function callback, {int page}) async {
    dio.get(Apis.PLANS_LIST, queryParameters: {"current": page}).then(
        (response) {
      callback(spiderPlansModelFromJson(new SpiderPlansModel(), response.data));
    });
  }
}
