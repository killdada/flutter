import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/page/course_detail_page/course_tab_component/course_catalog_component/component.dart';
import 'package:myapp/page/course_detail_page/course_tab_component/ppt_component/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class CourseTabComponent extends Component<CourseTabState> {
  CourseTabComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<CourseTabState>(
              adapter: null,
              slots: <String, Dependent<CourseTabState>>{
                'courseCatalog':
                    CourseCatalogConnector() + CourseCatalogComponent(),
                'ppt': PptConnector() + PptComponent(),
              }),
        );
}
