class Address {
  static const String host = "https://peiban-beta.mypaas.com.cn/api/v1/";

//   static const String _login = "login"; // 登录
//   static const String _userInfo = "user"; // 用户信息
//   static const String _banner = "carouse"; // 首页banner
//   static const String _category = "cateory"; // 首页课程类别
//   static const String _courseList = "course"; // 课程列表
//   static const String _learnRank = "user/rank"; // 学习时长排行
//   static const String _learnRecord = "user/learning/record"; // 学习记录

  /// 获取用户信息
  static getUserInfo() {
    return "${host}user";
  }

//  static getAuthorization() {
//     return "${host}authorizations";
//   }

//   // 搜索 get
//   static search(q, sort, order, type, page, [pageSize = Config.PAGE_SIZE]) {
//     if (type == 'user') {
//       return "${host}search/users?q=$q&page=$page&per_page=$pageSize";
//     }
//     sort ??= "best%20match";
//     order ??= "desc";
//     page ??= 1;
//     pageSize ??= Config.PAGE_SIZE;
//     return "${host}search/repositories?q=$q&sort=$sort&order=$order&page=$page&per_page=$pageSize";
//   }

//   // 搜索topic tag
//   static searchTopic(topic) {
//     return "${host}search/repositories?q=topic:$topic&sort=stars&order=desc";
//   }

  // 处理分页参数
//   static getPageParams(tab, page, [pageSize = Config.PAGE_SIZE]) {
//     if (page != null) {
//       if (pageSize != null) {
//         return "${tab}page=$page&per_page=$pageSize";
//       } else {
//         return "${tab}page=$page";
//       }
//     } else {
//       return "";
//     }
//   }
}
