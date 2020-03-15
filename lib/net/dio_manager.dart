import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_zjy/data/api/apis.dart';
import 'package:flutter_zjy/common/common.dart';
import 'package:flutter_zjy/utils/sp_util.dart';

import 'log_interceptor.dart';

Dio _dio = DioManager.getInstance()._dio;

Dio get dio => _dio;

/// dio 配置
class DioManager {
  static DioManager _instance = DioManager._internal();
  Dio _dio;

  factory DioManager() => _instance;

  ///通用全局单例，第一次使用时初始化
  DioManager._internal({String baseUrl}) {
    if (null == _dio) {
      _dio = new Dio(new BaseOptions(
          baseUrl: Apis.BASE_API,
          connectTimeout: 10000,
          headers: {"Authorization": SPUtil.getString(Constants.TOKEN_KEY)}));
      _dio.interceptors.add(new LogsInterceptors());
    }
  }

  static DioManager getInstance({String baseUrl}) {
    if (baseUrl == null) {
      return _instance._normal();
    } else {
      return _instance._baseUrl(baseUrl);
    }
  }

  //用于指定特定域名，比如cdn和kline首次的http请求
  DioManager _baseUrl(String baseUrl) {
    if (_dio != null) {
      _dio.options.baseUrl = baseUrl;
    }
    return this;
  }

  //一般请求，默认域名
  DioManager _normal() {
    if (_dio != null) {
      if (_dio.options.baseUrl != Apis.BASE_API) {
        _dio.options.baseUrl = Apis.BASE_API;
      }
    }
    return this;
  }

  static String handleError(error, {String defaultErrorStr = '未知错误~'}) {
    // 定义一个命名参数的方法
    String errStr;
    if (error is DioError) {
      if (error.type == DioErrorType.CONNECT_TIMEOUT) {
        errStr = '连接超时~';
      } else if (error.type == DioErrorType.SEND_TIMEOUT) {
        errStr = '请求超时~';
      } else if (error.type == DioErrorType.RECEIVE_TIMEOUT) {
        errStr = '响应超时~';
      } else if (error.type == DioErrorType.CANCEL) {
        errStr = '请求取消~';
      } else if (error.type == DioErrorType.RESPONSE) {
        int statusCode = error.response.statusCode;
        String msg = error.response.statusMessage;

        /// TODO 异常状态码的处理
        switch (statusCode) {
          case 500:
            errStr = '服务器异常~';
            break;
          case 404:
            errStr = '未找到资源~';
            break;
          default:
            errStr = '$msg[$statusCode]';
            break;
        }
      } else if (error.type == DioErrorType.DEFAULT) {
        errStr = '${error.message}';
        if (error.error is SocketException) {
          errStr = '网络连接超时~';
        }
      } else {
        errStr = '未知错误~';
      }
    }
    return errStr ?? defaultErrorStr;
  }
}
