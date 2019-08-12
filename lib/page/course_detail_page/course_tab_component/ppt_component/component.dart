import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/model/course-detail/course_detail_model.dart';


import 'view.dart';

class PptComponent extends Component<List<PptModel>> {
  PptComponent()
      : super(
          view: buildView,
        );
}
