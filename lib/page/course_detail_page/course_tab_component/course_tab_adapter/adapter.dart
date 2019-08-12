import 'dart:developer';

import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/model/course-detail/course_detail_model.dart';
import 'package:myapp/page/course_detail_page/course_tab_component/course_catalog_component/component.dart';
import 'package:myapp/page/course_detail_page/course_tab_component/course_title_component/component.dart';
import 'package:myapp/page/course_detail_page/course_tab_component/ppt_component/component.dart';

import '../reducer.dart';
import '../state.dart';

class CourseTabAdapter extends DynamicFlowAdapter<CourseTabState> {
  CourseTabAdapter()
      : super(
          pool: <String, Component<Object>>{
            'courseCatalog': CourseCatalogComponent(),
            'ppt': PptComponent(),
            'title': CourseTitleComponent(),
          },
          connector: _CourseTabConnector(),
          reducer: buildReducer(),
        );
}

class _CourseTabConnector extends ConnOp<CourseTabState, List<ItemBean>> {
  @override
  List<ItemBean> get(CourseTabState state) {
    List<ItemBean> result = [];
    if (state.courseDetail != null) {
      result.add(ItemBean('title', {'title': '课程目录'}));
      final List<CatalogsModel> catalogs = state.courseDetail.catalogs;
      catalogs.forEach((CatalogsModel data) {
        result.add(ItemBean('courseCatalog', data));
      });
      result.add(ItemBean('title', {
        'title': state.courseTabData.catalogName,
        'desc': state.courseTabData.pptTitle,
      }));
      result.add(ItemBean('ppt', state.courseTabData.ppt));
    }
    return result;
  }

  @override
  void set(CourseTabState state, List<ItemBean> items) {}

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
