import 'dart:developer';

import 'package:myapp/common/http/address.dart';
import 'package:myapp/common/http/http.dart';
import 'package:myapp/common/model/collection_model.dart';

class CollectionDao {
  // 获取我的收藏记录
  static Future getMyCollection() async {
    try {
      var res = await httpManager.fetch(Address.getCollectionList());
      var data = HttpManager.decodeJson(res);
      if (data != null) {
        return (data as List)
            .map((item) => CollectionModel.fromJson(item))
            .toList();
      } else {
        throw ('请求结果返回为null');
      }
    } catch (e) {
      throw (e);
    }
  }
}
