import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';
import 'search_component/component.dart';
import 'banner_component/component.dart';
import 'tabbar_component/component.dart';

class CoursePage extends Page<CourseState, Map<String, dynamic>> {
  CoursePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<CourseState>(
              //   adapter: NoneConn<CourseState>() + CourseListAdapter(),
              slots: <String, Dependent<CourseState>>{
                'search': SearchConnector() + SearchComponent(),
                'banner': BannerConnector() + BannerComponent(),
                'tabbar': TabbarConnector() + TabbarComponent(),
              }),
          middleware: <Middleware<CourseState>>[],
        );
}
