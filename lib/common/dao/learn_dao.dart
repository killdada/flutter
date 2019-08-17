
import 'package:myapp/common/http/address.dart';
import 'package:myapp/common/http/http.dart';
import 'package:myapp/common/model/learn_rank_item.dart';
import 'package:myapp/common/model/learn_record_model.dart';

class LearnDao {
  // 获取学习记录排行榜,type 1 本周排行榜 2 累计排行榜
  static Future getLearnRankList(int type) async {
    try {
      var res = await httpManager.fetch(Address.getLearnLank(), query: {
        'type': type,
      });

      var data = HttpManager.decodeJson(res);
      if (data != null) {
        return data['list']
            .map((item) => LearnRankItem.fromJson(item))
            .toList();
      } else {
        throw ('请求结果返回为null');
      }
    } catch (e) {
      throw (e);
    }
  }

  // 获取学习记录排行榜,type 1 本周排行榜 2 累计排行榜
  static Future getLearnRecordList() async {
    try {
      var res = await httpManager.fetch(Address.getLearnRecord());

      var data = HttpManager.decodeJson(res);

      if (data != null) {
        return data.map((json) => LearnRecordModel.fromJson(json)).toList();
      } else {
        throw ('请求结果返回为null');
      }
    } catch (e) {
      throw (e);
    }
  }
}
