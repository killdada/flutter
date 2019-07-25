import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/page/search_page/history_component/component.dart';
import 'package:myapp/page/search_page/search_header_component/component.dart';
import 'package:myapp/page/search_page/search_result_adapter/adapter.dart';
// import 'package:myapp/page/search_page/adapter.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SearchPage extends Page<SearchState, Map<String, dynamic>> {
  SearchPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<SearchState>(
              adapter: NoneConn<SearchState>() + SearchResultAdapter(),
              slots: <String, Dependent<SearchState>>{
                "search": SearchHeaderConnector() + SearchHeaderComponent(),
                "history": HistoryConnector() + HistoryComponent(),
              }),
          middleware: <Middleware<SearchState>>[],
        );
}
