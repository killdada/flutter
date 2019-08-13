import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:myapp/common/model/course-detail/index.dart';

//TODO replace with your own action
enum CourseDetailAction {
  onFetchDetail,
  initData,
  changeIndex,
  changeCurrentTab,
  changeShowAll,
  changeCollect,
  changePptIndex
}

class CourseDetailActionCreator {
  static Action onFetchDetail() {
    return const Action(CourseDetailAction.onFetchDetail);
  }

  static Action initData(
      CourseDetailModel detail, TabController tabController) {
    return Action(
      CourseDetailAction.initData,
      payload: {'detail': detail, 'tabController': tabController},
    );
  }

  static Action changeShowAll() {
    return const Action(CourseDetailAction.changeShowAll);
  }

  static Action changeIndex() {
    return const Action(CourseDetailAction.changeIndex);
  }

  static Action changeCollect() {
    return const Action(CourseDetailAction.changeCollect);
  }

  static Action changeCurrentTab(CatalogsModel catalog) {
    return Action(
      CourseDetailAction.changeCurrentTab,
      payload: catalog,
    );
  }

  static Action changePptIndex(int index) {
    return Action(CourseDetailAction.changePptIndex, payload: index);
  }
}
