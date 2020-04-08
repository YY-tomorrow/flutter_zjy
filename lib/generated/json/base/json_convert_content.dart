// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:flutter_zjy/data/model/products_model.dart';
import 'package:flutter_zjy/generated/json/products_model_helper.dart';
import 'package:flutter_zjy/data/model/news_model.dart';
import 'package:flutter_zjy/generated/json/news_model_helper.dart';
import 'package:flutter_zjy/data/model/token_model.dart';
import 'package:flutter_zjy/generated/json/token_model_helper.dart';
import 'package:flutter_zjy/data/model/our_plans_model.dart';
import 'package:flutter_zjy/generated/json/our_plans_model_helper.dart';
import 'package:flutter_zjy/data/model/empty_response_model.dart';
import 'package:flutter_zjy/generated/json/empty_response_model_helper.dart';
import 'package:flutter_zjy/data/model/spider_plans_model.dart';
import 'package:flutter_zjy/generated/json/spider_plans_model_helper.dart';
import 'package:flutter_zjy/data/model/refreshtoken_model.dart';
import 'package:flutter_zjy/generated/json/refreshtoken_model_helper.dart';
import 'package:flutter_zjy/data/model/userinfo_model.dart';
import 'package:flutter_zjy/generated/json/userinfo_model_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }  static _getFromJson<T>(Type type, data, json) {
    switch (type) {			case ProductsModel:
			return productsModelFromJson(data as ProductsModel, json) as T;			case ProductsData:
			return productsDataFromJson(data as ProductsData, json) as T;			case NewsModel:
			return newsModelFromJson(data as NewsModel, json) as T;			case NewsData:
			return newsDataFromJson(data as NewsData, json) as T;			case NewsDataData:
			return newsDataDataFromJson(data as NewsDataData, json) as T;			case TokenModel:
			return tokenModelFromJson(data as TokenModel, json) as T;			case TokenData:
			return tokenDataFromJson(data as TokenData, json) as T;			case OurPlansModel:
			return ourPlansModelFromJson(data as OurPlansModel, json) as T;			case OurPlansData:
			return ourPlansDataFromJson(data as OurPlansData, json) as T;			case OurPlansDataPlan:
			return ourPlansDataPlanFromJson(data as OurPlansDataPlan, json) as T;			case OurPlansDataPlansItem:
			return ourPlansDataPlansItemFromJson(data as OurPlansDataPlansItem, json) as T;			case EmptyResponseModel:
			return emptyResponseModelFromJson(data as EmptyResponseModel, json) as T;			case SpiderPlansModel:
			return spiderPlansModelFromJson(data as SpiderPlansModel, json) as T;			case SpiderPlansData:
			return spiderPlansDataFromJson(data as SpiderPlansData, json) as T;			case SpiderPlansDataPlan:
			return spiderPlansDataPlanFromJson(data as SpiderPlansDataPlan, json) as T;			case SpiderPlansDataPlansElemants:
			return spiderPlansDataPlansElemantsFromJson(data as SpiderPlansDataPlansElemants, json) as T;			case RefreshtokenModel:
			return refreshtokenModelFromJson(data as RefreshtokenModel, json) as T;			case UserinfoModel:
			return userinfoModelFromJson(data as UserinfoModel, json) as T;			case UserinfoData:
			return userinfoDataFromJson(data as UserinfoData, json) as T;    }
    return data as T;
  }  static _getToJson<T>(Type type, data) {
		switch (type) {			case ProductsModel:
			return productsModelToJson(data as ProductsModel);			case ProductsData:
			return productsDataToJson(data as ProductsData);			case NewsModel:
			return newsModelToJson(data as NewsModel);			case NewsData:
			return newsDataToJson(data as NewsData);			case NewsDataData:
			return newsDataDataToJson(data as NewsDataData);			case TokenModel:
			return tokenModelToJson(data as TokenModel);			case TokenData:
			return tokenDataToJson(data as TokenData);			case OurPlansModel:
			return ourPlansModelToJson(data as OurPlansModel);			case OurPlansData:
			return ourPlansDataToJson(data as OurPlansData);			case OurPlansDataPlan:
			return ourPlansDataPlanToJson(data as OurPlansDataPlan);			case OurPlansDataPlansItem:
			return ourPlansDataPlansItemToJson(data as OurPlansDataPlansItem);			case EmptyResponseModel:
			return emptyResponseModelToJson(data as EmptyResponseModel);			case SpiderPlansModel:
			return spiderPlansModelToJson(data as SpiderPlansModel);			case SpiderPlansData:
			return spiderPlansDataToJson(data as SpiderPlansData);			case SpiderPlansDataPlan:
			return spiderPlansDataPlanToJson(data as SpiderPlansDataPlan);			case SpiderPlansDataPlansElemants:
			return spiderPlansDataPlansElemantsToJson(data as SpiderPlansDataPlansElemants);			case RefreshtokenModel:
			return refreshtokenModelToJson(data as RefreshtokenModel);			case UserinfoModel:
			return userinfoModelToJson(data as UserinfoModel);			case UserinfoData:
			return userinfoDataToJson(data as UserinfoData);    }
    return data as T;
  }  static T fromJsonAsT<T>(json) {
    switch (T.toString()) {			case 'ProductsModel':
			return ProductsModel().fromJson(json) as T;			case 'ProductsData':
			return ProductsData().fromJson(json) as T;			case 'NewsModel':
			return NewsModel().fromJson(json) as T;			case 'NewsData':
			return NewsData().fromJson(json) as T;			case 'NewsDataData':
			return NewsDataData().fromJson(json) as T;			case 'TokenModel':
			return TokenModel().fromJson(json) as T;			case 'TokenData':
			return TokenData().fromJson(json) as T;			case 'OurPlansModel':
			return OurPlansModel().fromJson(json) as T;			case 'OurPlansData':
			return OurPlansData().fromJson(json) as T;			case 'OurPlansDataPlan':
			return OurPlansDataPlan().fromJson(json) as T;			case 'OurPlansDataPlansItem':
			return OurPlansDataPlansItem().fromJson(json) as T;			case 'EmptyResponseModel':
			return EmptyResponseModel().fromJson(json) as T;			case 'SpiderPlansModel':
			return SpiderPlansModel().fromJson(json) as T;			case 'SpiderPlansData':
			return SpiderPlansData().fromJson(json) as T;			case 'SpiderPlansDataPlan':
			return SpiderPlansDataPlan().fromJson(json) as T;			case 'SpiderPlansDataPlansElemants':
			return SpiderPlansDataPlansElemants().fromJson(json) as T;			case 'RefreshtokenModel':
			return RefreshtokenModel().fromJson(json) as T;			case 'UserinfoModel':
			return UserinfoModel().fromJson(json) as T;			case 'UserinfoData':
			return UserinfoData().fromJson(json) as T;    }
    return null;
  }}