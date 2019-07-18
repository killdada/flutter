import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SearchComponent extends Component<SearchState> {
  SearchComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<SearchState>(
                adapter: null,
                slots: <String, Dependent<SearchState>>{
                }),);

}
