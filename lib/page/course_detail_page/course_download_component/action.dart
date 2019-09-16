import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum CourseDownloadAction { onClickItem, onDownloadItem }

class CourseDownloadActionCreator {
  static Action onClickItem(int type) {
    return Action(CourseDownloadAction.onClickItem, payload: type);
  }

  static Action onDownloadItem(int index) {
    return Action(CourseDownloadAction.onDownloadItem, payload: index);
  }
}
