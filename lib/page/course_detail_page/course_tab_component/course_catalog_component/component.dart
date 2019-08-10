import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class CourseCatalogComponent extends Component<CourseCatalogState> {
  CourseCatalogComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<CourseCatalogState>(
                adapter: null,
                slots: <String, Dependent<CourseCatalogState>>{
                }),);

}
