import 'package:dio/dio.dart';

import 'package:myapp/common/http/address.dart';
import 'package:myapp/common/http/http.dart';
import 'package:myapp/common/model/practice_detail_model.dart';

class PracticeDao {
  /// 获取；练习详情
  static Future getPracticeDetail(int practiceId) async {
    try {
      var res =
          await httpManager.fetch('${Address.getPracticeReply()}/$practiceId');
      var data = HttpManager.decodeJson(res);
      return PractiveDetailModel.fromJson(data);
    } catch (e) {}
  }

  /// 对练习详情里面的回复喜欢点赞
  static Future practiceReplyLike(int replyId) async {
    return await httpManager.fetch(
      '${Address.getPracticeReplyFab()}/$replyId',
      option: Options(
        method: 'put',
      ),
    );
  }

  /// 对练习喜欢点赞
  static Future practiceLike(int practiceId) async {
    return await httpManager.fetch(
      '${Address.getPracticeFab()}/$practiceId',
      option: Options(
        method: 'put',
      ),
    );
  }

  /// 练习详情评论
  static Future practiceReplay(int practiceId, String content) async {
    return await httpManager.fetch(
      '${Address.getPracticeReply()}/$practiceId',
      option: Options(
        method: 'post',
      ),
      params: {'content': content},
    );
  }

// 练习概览
  static Future practice(
    int courseId,
    int practiceId,
  ) async {
    try {
      var res = await httpManager
          .fetch('${Address.getPractice()}/$courseId/$practiceId');
      var data = HttpManager.decodeJson(res);
      return PractiveDetailModel.fromJson(data);
    } catch (e) {}
  }

  /// 练习详情评论
  static Future practiceSubmit(
    int courseId,
    int practiceId,
    String title,
    String content,
  ) async {
    return await httpManager.fetch(
      '${Address.getPracticeSubmit()}/$courseId/$practiceId',
      option: Options(
        method: 'post',
      ),
      params: {
        'title': title,
        'content': content,
      },
    );
  }
}
