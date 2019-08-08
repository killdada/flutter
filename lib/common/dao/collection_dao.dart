import 'dart:developer';

import 'package:myapp/common/http/address.dart';
import 'package:myapp/common/http/http.dart';
import 'package:myapp/common/model/collection_model.dart';
import 'package:dio/dio.dart';

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

  // 删除取消收藏记录
  static Future deleCollection(List<int> ids) async {
    return await httpManager.fetch(
        '${Address.getCollectionList()}/${ids.join(',')}',
        option: Options(method: "delete"));
  }
}
