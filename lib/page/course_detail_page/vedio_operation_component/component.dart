import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class VedioOperationComponent extends Component<VedioOperationState> {
  VedioOperationComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<VedioOperationState>(
                adapter: null,
                slots: <String, Dependent<VedioOperationState>>{
                }),);

}
