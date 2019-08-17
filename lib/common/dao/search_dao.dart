
import 'package:myapp/common/http/address.dart';
import 'package:myapp/common/http/http.dart';

class SearchDao {
  // 获取首页banner数据
  static Future search(String key) async {
    try {
      var res = await httpManager.fetch(Address.getSearch(), query: {
        'keyword': key,
      });
      var data = HttpManager.decodeJson(res);
      return data;
    } catch (e) {
      throw (e);
    }
  }
}
