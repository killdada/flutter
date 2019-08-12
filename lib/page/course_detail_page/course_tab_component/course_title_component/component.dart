import 'package:fish_redux/fish_redux.dart';

import 'view.dart';

class CourseTitleComponent extends Component<Map<String, dynamic>> {
  CourseTitleComponent()
      : super(
          view: buildView,
        );
}
