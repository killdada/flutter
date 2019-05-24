import 'dart:convert';

import 'package:myapp/common/config/config.dart';
import 'package:myapp/common/http/address.dart';
import 'package:myapp/common/http/http.dart';
import 'package:myapp/common/utils/local_storage.dart';
import 'package:myapp/common/model/userinfo.dart';
import 'dao_result.dart';

class UserDao {
  ///获取用户详细信息
  static Future getUserInfo() async {
    var res = await httpManager.fetch(Address.getUserInfo());

    if (res != null && res.result) {
      UserInfo user = UserInfo.fromJson(res.data);
      LocalStorage.save(Config.USER_INFO, json.encode(user.toJson()));
      return new DataResult(user, true);
    } else {
      return new DataResult(res.data, false);
    }
  }
}
