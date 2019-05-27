import 'package:dio/dio.dart';
import 'package:myapp/common/config/config.dart';
import 'package:myapp/common/utils/data_utils.dart';
import 'package:myapp/common/utils/local_storage.dart';

/*
 * Token拦截器
 * Created by guoshuyu
 * on 2019/3/23.
 */
class TokenInterceptors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    //授权码
    String token = await DataUtils.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.queryParameters = options.queryParameters ?? {};
      options.queryParameters['token'] = token;
      print(options.queryParameters.toString());
    }
    return options;
  }
}
