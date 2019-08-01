import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:myapp/common/config/config.dart';
import 'package:myapp/common/event/event_bus.dart';
import 'package:myapp/common/event/login_event.dart';
import 'package:myapp/common/http/address.dart';
import 'package:myapp/common/http/http.dart';
import 'package:myapp/common/utils/data_utils.dart';
import 'package:myapp/common/utils/local_storage.dart';
import 'package:myapp/common/model/userinfo.dart';

class UserDao {
  ///获取用户详细信息
  static Future getUserInfo() async {
    UserInfo user = await DataUtils.getUserInstance();
    if (user != null) {
      // 存储里面有直接拿
      return user;
    }
    var result;
    try {
      var res = await httpManager.fetch(Address.getUserInfo());
      var data = HttpManager.decodeJson(res);
      if (data != null) {
        UserInfo userData = UserInfo.fromJson(data);
        LocalStorage.save(Config.USER_INFO, json.encode(userData.toJson()));
        result = userData;
      }
    } catch (e) {}
    return result;
  }

  static Future login(String username, String password) async {
    try {
      var res = await httpManager.fetch(
        Address.doLogin(),
        params: {
          'username': username,
          'password': password,
        },
        option: Options(method: "post"),
      );

      var data = HttpManager.decodeJson(res);
      if (data != null) {
        await DataUtils.login(data['access_token']);
        MyEventBus.event.fire(LoginEvent());
      } else {
        throw (res['msg']);
      }
    } catch (e) {
      throw (e);
    }
  }
}
