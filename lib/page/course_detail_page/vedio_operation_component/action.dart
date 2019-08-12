import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/constant/constant.dart';
import 'package:myapp/common/model/course-detail/course_detail_model.dart';

//TODO replace with your own action
enum VedioOperationAction { onClickItem, changeCollect }

class VedioOperationActionCreator {
  static Action onClickItem(ActionType type, CourseDetailModel detail) {
    return Action(
      VedioOperationAction.onClickItem,
      payload: {'type': type, 'detail': detail},
    );
  }

  static Action changeCollect() {
    return Action(VedioOperationAction.changeCollect);
  }
}
