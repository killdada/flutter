import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/model/course-detail/index.dart';

class VedioOperationState implements Cloneable<VedioOperationState> {
  CatalogsModel vedioOperationData;
  @override
  VedioOperationState clone() {
    return VedioOperationState()..vedioOperationData = vedioOperationData;
  }
}
