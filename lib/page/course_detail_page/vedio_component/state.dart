import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/model/course-detail/index.dart';

class VedioState implements Cloneable<VedioState> {
  CatalogsModel vedioData;
  @override
  VedioState clone() {
    return VedioState()..vedioData = vedioData;
  }
}
