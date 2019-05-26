import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:myapp/common/config/config.dart';
import 'package:myapp/common/event/event_bus.dart';
import 'package:myapp/common/event/login_event.dart';
import 'package:myapp/common/http/address.dart';
import 'package:myapp/common/http/http.dart';
import 'package:myapp/common/utils/data_utils.dart';
import 'package:myapp/common/utils/local_storage.dart';
import 'package:myapp/common/model/userinfo.dart';
import 'dao_result.dart';
import 'dart:developer';

class UserDao {
  ///获取用户详细信息
  static Future getUserInfo() async {
    UserInfo user = await DataUtils.getUserInstance();
    if (user != null) {
      return user;
    }
    var res = await httpManager.fetch(Address.getUserInfo());

    if (res != null && res.result) {
      var data = HttpManager.decodeJson(res.data);
      UserInfo userData = UserInfo.fromJson(data);
      LocalStorage.save(Config.USER_INFO, json.encode(userData.toJson()));
      return userData;
    } else {
      return null;
    }
  }

  static Future login(String username, String password) async {
    var res = await httpManager.fetch(
      Address.doLogin(),
      params: {
        'username': username,
        'password': password,
      },
      option: Options(method: "post"),
    );

    if (res != null && res.result) {
      var data = HttpManager.decodeJson(res.data);
      await DataUtils.login(data['access_token']);
      MyEventBus.event.fire(LoginEvent());
      return new DataResult(res.data, true);
    } else {
      return new DataResult(null, false);
    }
  }
}
