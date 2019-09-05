import 'package:dio/dio.dart';
import 'package:myapp/common/http/address.dart';
import 'package:myapp/common/http/http.dart';
import 'package:myapp/common/model/course-detail/course_detail_model.dart';
import 'package:myapp/common/model/course-detail/course_detail_topic.dart';

class CourseDetailDao {
  // 获取课程详情
  static Future getCourseDetail(int courseId) async {
    try {
      var res =
          await httpManager.fetch('${Address.getCourseDetail()}/$courseId');
      var data = HttpManager.decodeJson(res);
      if (data != null) {
        return CourseDetailModel.fromJson(data);
      } else {
        throw ('请求结果返回为null');
      }
    } catch (e) {
      throw (e);
    }
  }

  static Future reportLearningTime(
      int courseId, int catalogId, int time) async {
    return httpManager
        .fetch('${Address.getReportLeaningTime()}/$courseId/$catalogId',
            option: Options(
              method: 'post',
            ),
            params: {
          'time': time,
        });
  }

  // 获取练习详情, sortType "time" | "hot";
  static Future getPracticeDetail(int practiceId, String sortType) async {
    try {
      var res = await httpManager.fetch(
          '${Address.getcourseDetailTopic()}/$practiceId',
          query: {"sort": sortType});
      var data = HttpManager.decodeJson(res);
      if (data != null) {
        return CourseDetailTopic.fromJson(data);
      } else {
        throw ('请求结果返回为null');
      }
    } catch (e) {
      throw (e);
    }
  }
}
