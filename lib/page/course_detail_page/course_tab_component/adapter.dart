

import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/constant/constant.dart';
import 'package:myapp/common/model/course-detail/course_detail_model.dart';
import 'package:myapp/page/course_detail_page/course_tab_component/course_catalog_component/component.dart';
import 'package:myapp/page/course_detail_page/course_tab_component/course_title_component/component.dart';
import 'package:myapp/page/course_detail_page/course_tab_component/ppt_component/component.dart';

import 'reducer.dart';
import 'state.dart';

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
    // 简洁模式只有显示ppt
    List<ItemBean> result = [];
    bool isSimple = state.videoEventData.videoModel == VideoModel.simple;
    if (state.courseDetail != null && state.courseDetail.catalogs.isNotEmpty) {
      if (!isSimple) {
        result.add(ItemBean('title', {'title': '课程目录'}));
        final List<CatalogsModel> catalogs = state.courseDetail.catalogs;
        int count = state.showAll ? catalogs.length : (catalogs.length <= 3 ? catalogs.length : 3);
        for (int i = 0; i < count; i++) {
          CatalogsModel data = catalogs[i];
          result.add(ItemBean('courseCatalog', {
            'catalog': data,
            'index': i,
            'showAll': state.showAll || count - 1 != i,
            'count': count,
            'needDivision': state.courseTabData.ppt.isNotEmpty,
          }));
        }
      }
      if (state.courseTabData.ppt.isNotEmpty) {
        if (!isSimple) {
          result.add(ItemBean('title', {
            'title': state.courseTabData.catalogName,
            'desc': state.courseTabData.pptTitle,
          }));
        }
        result.add(ItemBean(
          'ppt',
          {'list': state.courseTabData.ppt, 'index': state.pptIndex},
        ));
      }
    }
    return result;
  }

  @override
  void set(CourseTabState state, List<ItemBean> items) {}

  @override
  subReducer(reducer) {
    return super.subReducer(reducer);
  }
}
