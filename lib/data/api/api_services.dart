import 'package:flutter_zjy/data/api/apis.dart';
import 'package:flutter_zjy/generated/json/news_model_helper.dart';
import 'package:flutter_zjy/data/model/news_model.dart';
import 'package:flutter_zjy/net/dio_manager.dart';

ApiService _apiService = new ApiService();

ApiService get apiService => _apiService;

class ApiService {
  // 首页获取新闻资讯
  void getNewsList(Function callback, {int size, String cursor}) async {
    dio.get(Apis.NEWS_LIST, queryParameters: {
      "page_size": size,
      "cursor": cursor
    }).then((response) {
      callback(newsModelFromJson(new NewsModel(), response.data));
    });
  }
}
