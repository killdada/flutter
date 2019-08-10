import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class VedioComponent extends Component<VedioState> {
  VedioComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<VedioState>(
                adapter: null,
                slots: <String, Dependent<VedioState>>{
                }),);

}
