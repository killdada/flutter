import 'dart:developer';

import 'package:myapp/common/http/address.dart';
import 'package:myapp/common/http/http.dart';

import 'package:myapp/common/model/course/banner.dart';
import 'package:myapp/common/model/course/category.dart';
import 'package:myapp/common/model/course/course.dart';

class CourseDao {
  // 获取首页banner数据
  static Future getBanners() async {
    try {
      var res = await httpManager.fetch(Address.getBanners());
      var data = HttpManager.decodeJson(res);
      if (data != null) {
        List<BannerModel> result =
            (data as List).map((v) => BannerModel.fromJson(v)).toList();
        return result;
      } else {
        throw ('请求结果返回为null');
      }
    } catch (e) {
      throw (e);
    }
  }

  // 获取首页课程所以的分类列表
  static Future getCategories() async {
    try {
      var res = await httpManager.fetch(Address.getCategories());
      var data = HttpManager.decodeJson(res);
      if (data != null) {
        List<CategoryModel> result =
            (data as List).map((v) => CategoryModel.fromJson(v)).toList();
        return result;
      } else {
        throw ('请求结果返回为null');
      }
    } catch (e) {
      throw (e);
    }
  }

  // 获取首页某个分类下的课程列表数据
  static Future getCourseList({categoryId}) async {
    try {
      var res = await httpManager
          .fetch(Address.getCourseList(), query: {'category_id': categoryId});
      var data = HttpManager.decodeJson(res);
      if (data != null) {
        List<CourseModel> result =
            (data as List).map((v) => CourseModel.fromJson(v)).toList();
        return result;
      } else {
        throw ('请求结果返回为null');
      }
    } catch (e) {
      throw (e);
    }
  }
}
