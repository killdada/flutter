import 'dart:developer';

import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/model/course/category.dart';
import 'package:myapp/common/model/course/course.dart';

import 'package:myapp/page/course_page/banner_component/component.dart';
import 'package:myapp/common/model/course/banner.dart';

import 'action.dart';
import 'state.dart';

Reducer<CourseState> buildReducer() {
  return asReducer(
    <Object, Reducer<CourseState>>{
      CourseAction.loadBanner: _loadBanner,
      CourseAction.loadCategory: _loadCategory,
    },
  );
}

CourseState _loadBanner(CourseState state, Action action) {
  final CourseState newState = state.clone();
  List<BannerModel> banners = action.payload;
  newState.bannerList = banners;
  return newState;
}

CourseState _loadCategory(CourseState state, Action action) {
  final CourseState newState = state.clone();
  List<CategoryModel> categories = action.payload;
  try {
    newState.tabbarList = categories;
    // if (categories.isNotEmpty) {
    //   newState.categoryId = categories[0].categoryId;
    //   debugger();
    //   print('yenin>>>>${newState.categoryId}');
    // }
  } catch (e) {
    // debugger();
    print('yenin111>>>>${e}');
  }

  return newState;
}
