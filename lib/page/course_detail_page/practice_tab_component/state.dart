import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/model/course-detail/index.dart';

class PracticeTabState implements Cloneable<PracticeTabState> {
  CatalogsModel practiceData;
  @override
  PracticeTabState clone() {
    return PracticeTabState()..practiceData = practiceData;
  }
}

PracticeTabState initState(Map<String, dynamic> args) {
  return PracticeTabState();
}
