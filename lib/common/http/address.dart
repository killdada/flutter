class Address {
  static const String host = "https://peiban.mypaas.com.cn/api/v1/";

  static const String _login = "login"; // 登录
  static const String _userInfo = "user"; // 用户信息
//   static const String _banner = "carouse"; // 首页banner
//   static const String _category = "cateory"; // 首页课程类别
//   static const String _courseList = "course"; // 课程列表
//   static const String _learnRank = "user/rank"; // 学习时长排行
//   static const String _learnRecord = "user/learning/record"; // 学习记录

  /// 获取用户信息
  static getUserInfo() {
    return "$host$_userInfo";
  }

  /// 登录
  static doLogin() {
    return "$host$_login";
  }
}
