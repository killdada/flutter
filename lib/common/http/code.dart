import 'package:myapp/common/event/http_error_event.dart';
import 'package:myapp/common/event/event_bus.dart';

///错误编码
class Code {
  ///网络错误
  static const NETWORK_ERROR = -1;

  ///网络超时
  static const NETWORK_TIMEOUT = -2;

  // 成功请求code
  static const SUCCESS = 200;

  // 错误的回调函数
  static errorHandleFunction(code, message, noTip) {
    if (noTip) {
      return message;
    }
    eventBus.event.fire(new HttpErrorEvent(code, message));
    return message;
  }
}
