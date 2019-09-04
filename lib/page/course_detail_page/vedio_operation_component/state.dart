import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/constant/constant.dart';
import 'package:myapp/common/model/course-detail/index.dart';

class VedioOperationState implements Cloneable<VedioOperationState> {
  CourseDetailModel vedioOperationData;
  bool collected;
  PlayType pageType = PlayType.video;
  @override
  VedioOperationState clone() {
    return VedioOperationState()
      ..collected = collected
      ..vedioOperationData = vedioOperationData
      ..pageType = pageType;
  }
}
