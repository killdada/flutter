import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SearchHeaderComponent extends Component<SearchHeaderState> {
  SearchHeaderComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<SearchHeaderState>(
                adapter: null,
                slots: <String, Dependent<SearchHeaderState>>{
                }),);

}
