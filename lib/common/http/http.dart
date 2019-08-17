import 'package:dio/dio.dart';
import 'package:myapp/common/http/code.dart';
import 'dart:collection';
import 'dart:io';

import 'package:myapp/common/http/interceptors/log_interceptor.dart';

import 'package:myapp/common/http/interceptors/token_interceptor.dart';

class DataResult<T> {
  int code;
  String msg;
  T data;

  DataResult(this.code, this.msg, this.data);

  @override
  String toString() {
    return 'BaseResp{code: $code, msg: $msg, data: $data}';
  }
}

// http请求
class HttpManager {
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";
  static BaseOptions options = new BaseOptions(
    baseUrl: '',
    connectTimeout: 20000,
    receiveTimeout: 20000,
    contentType: ContentType.json,
    queryParameters: {},
  );

  Dio _dio = new Dio(options); // 使用默认配置

  HttpManager() {
    _dio.interceptors.add(new TokenInterceptors());

    _dio.interceptors.add(new LogsInterceptors());
  }

  /*
   * 发起网络请求
   * url 请求地址
   * params 请求参数
   * header 请求头
   * option 请求配置
   */
  fetch(
    url, {
    params,
    Map<String, dynamic> header,
    Options option,
    Map<String, dynamic> query,
    bool noTip = false,
  }) async {
    Map<String, dynamic> headers = new HashMap();
    if (header != null) {
      headers.addAll(header);
    }

    if (option != null) {
      option.headers = headers;
    } else {
      option = new Options(method: "get");
      option.headers = headers;
    }

    Response response;
    try {
      response = await _dio.request(
        url,
        data: params,
        options: option,
        queryParameters: query,
      );
      return response.data;
    } on DioError catch (e) {
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = Response(statusCode: 666);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorResponse.statusCode = Code.NETWORK_TIMEOUT;
      }
      Code.errorHandleFunction(errorResponse.statusCode, e.message, noTip);
      return {'code': errorResponse.statusCode, 'msg': e.message, 'data': null};
    }
  }

  // 解析返回结果，最终只返回data数据
  static decodeJson<T>(Map response) {
    DataResult resp =
        DataResult(response['code'], response['msg'], response['data']);
    return resp.data;
  }
}

final HttpManager httpManager = new HttpManager();
