import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/model/course-detail/course_detail_model.dart';

class PptState implements Cloneable<PptState> {
  List<PptModel> pptData;
  int curPptIndex = 0;
  @override
  PptState clone() {
    return PptState()
      ..pptData = pptData
      ..curPptIndex = curPptIndex;
  }
}

PptState initState(Map<String, dynamic> args) {
  return PptState();
}
