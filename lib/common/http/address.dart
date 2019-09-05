class Address {
  static const String host = "https://peiban-beta.mypaas.com.cn/api/v1/";

  static const String _login = "login"; // 登录
  static const String _userInfo = "user"; // 用户信息
  static const String _banner = "carouse"; // 首页banner
  static const String _category = "cateory"; // 首页课程类别
  static const String _courseList = "course"; // 课程列表
  static const String _learnRank = "user/rank"; // 学习时长排行
  static const String _learnRecord = "user/learning/record"; // 学习记录
  static const String _courseDetail = "course"; // 课程详情
  static const String _collection = "collection"; // 收藏
  static const String _material = "material"; // 文件上传
  static const String _feedback = "feedback"; // 反馈
  static const String _search = "search"; // 搜索
  static const String _reportLeaningTime = "learning/report/time"; //上报学习时长

  // static const String _practiceReply = "practice_replay"; // 主题练习详情、回复
  // static const String _practiceFab = "practice_fab"; // 主题练习点赞
  // static const String _practiceReplyFab = "practice_replay_fab"; // 主题练习评论点赞
  // static const String _practice = "practice"; // 主题概览
  // static const String _practiceSubmit = "practice/reply"; // 提交练习
  static const String _courseDetailTopic = "topic/practice"; //课程详情里面的课后练习
  // static const String _reportLeaning = "learning/report/record"; //上报学习记录
  // static const String _deleteCollectionByCourse =
  //     "collection_by_course"; //上报学习时长

  /// 获取用户信息
  static getUserInfo() {
    return "$host$_userInfo";
  }

  /// 登录
  static doLogin() {
    return "$host$_login";
  }

  /// 学习记录排行榜
  static getLearnLank() {
    return "$host$_learnRank";
  }

  /// 学习记录
  static getLearnRecord() {
    return "$host$_learnRecord";
  }

  /// 获取banner信息
  static getBanners() {
    return "$host$_banner";
  }

  /// 获取分类信息
  static getCategories() {
    return "$host$_category";
  }

  /// 获取课程列表
  static getCourseList() {
    return "$host$_courseList";
  }

  /// 根据关键字搜索课程
  static getSearch() {
    return "$host$_search";
  }

  /// 获取我收藏的课程
  static getCollectionList() {
    return "$host$_collection";
  }

  /// 文件上传
  static getMaterial() {
    return "$host$_material";
  }

  /// 意见反馈
  static getFeedback() {
    return "$host$_feedback";
  }

  // 获取课程详情
  static getCourseDetail() {
    return "$host$_courseDetail";
  }

  /// 学习时间上报
  static getReportLeaningTime() {
    return "$host$_reportLeaningTime";
  }

  /// 课程详情里面的课后练习
  static getcourseDetailTopic() {
    return "$host$_courseDetailTopic";
  }
}
