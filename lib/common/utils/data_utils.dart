import 'dart:async';

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
    await LocalStorage.save(Config.TOKEN_KEY, '');
    await LocalStorage.save(Config.USER_INFO, '');
  }

  /// 保存用户个人信息
  static saveUserInfo(Map data) async {
    if (data != null) {
      await LocalStorage.save(Config.USER_INFO, data);
    }
  }

  /// 获取用户信息
  static getUserInfo() async {
    bool isLogin = await DataUtils.isLogin();
    if (!isLogin) {
      return null;
    }
    UserInfo userInfo = UserInfo(
      id: 212332,
      account: 'yen',
      name: '叶宁',
      email: 'yen@mingyuan.com.cn',
      avatar: '',
    );
    return userInfo;
  }

  /// 是否登录
  static isLogin() async {
    String token = await LocalStorage.get(Config.TOKEN_KEY);
    return token != null;
  }

  // 获取accesstoken
  static getAccessToken() async {
    String token = await LocalStorage.get(Config.TOKEN_KEY);
    return token;
  }
}
