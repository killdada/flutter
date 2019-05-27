import 'dart:convert';

import './local_storage.dart';
import '../config/config.dart';
import '../model/userinfo.dart';

class DataUtils {
  /// 保存登录的token
  static login(String token) async {
    if (token != null) {
      await LocalStorage.save(Config.TOKEN_KEY, token);
    }
  }

  /// 清除登录信息
  static logout() async {
    await LocalStorage.clear();
  }

  static getUserInstance() async {
    var result;
    try {
      String user = await LocalStorage.get(Config.USER_INFO);
      if (user != null && user != '') {
        Map userMap = json.decode(user);
        result = UserInfo.fromJson(userMap);
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  /// 获取用户信息
  static getUserInfo() async {
    bool isLogin = await DataUtils.isLogin();
    if (!isLogin) {
      return null;
    }
    return await getUserInstance();
  }

  /// 是否登录
  static isLogin() async {
    String token = await LocalStorage.get(Config.TOKEN_KEY);
    return token != null && token != '';
  }

  // 获取accesstoken
  static getAccessToken() async {
    String token = await LocalStorage.get(Config.TOKEN_KEY);
    return token;
  }
}
