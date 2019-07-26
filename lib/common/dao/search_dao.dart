import 'dart:developer';

import 'package:myapp/common/http/address.dart';
import 'package:myapp/common/http/http.dart';

class SearchDao {
  // 获取首页banner数据
  static Future search(String key) async {
    try {
      var res = await httpManager.fetch(Address.getSearch(), query: {
        'keyword': key,
      });
      var data = HttpManager.decodeJson(res);
      if (data != null) {
        return data;
      } else {
        throw ('请求结果返回为null');
      }
    } catch (e) {
      throw (e);
    }
  }
}
