import 'package:fish_redux/fish_redux.dart';
import 'package:fluro/fluro.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/common/constant/constant.dart';
import 'package:myapp/common/dao/collection_dao.dart';
import 'package:myapp/common/model/course-detail/index.dart';
import 'package:myapp/common/utils/data_utils.dart';
import 'package:myapp/page/course_detail_page/action.dart';
import 'package:myapp/router/application.dart';
import 'package:myapp/router/routers.dart';
import 'action.dart';
import 'state.dart';

Effect<VedioOperationState> buildEffect() {
  return combineEffects(<Object, Effect<VedioOperationState>>{
    VedioOperationAction.onClickItem: _onClickItem,
  });
}

void changeCollection(Context<VedioOperationState> ctx, int id) async {
  bool logined = await DataUtils.isLogin();
  if (!logined) {
    Fluttertoast.showToast(msg: '请先登录');
  } else if (!ctx.state.collected) {
    // 取消收藏
    try {
      await CollectionDao.addCollection(id);
      ctx.dispatch(CourseDetailActionCreator.changeCollect());
      Fluttertoast.showToast(msg: '收藏成功');
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  } else {
    // 添加收藏
    try {
      await CollectionDao.deleCollection([id]);
      ctx.dispatch(CourseDetailActionCreator.changeCollect());
      Fluttertoast.showToast(msg: '取消收藏成功');
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}

void _onClickItem(Action action, Context<VedioOperationState> ctx) {
  Map data = action.payload;
  ActionType type = data['type'];
  CourseDetailModel detail = data['detail'];
  switch (type) {
    case ActionType.share:
      break;
    case ActionType.download:
      ctx.dispatch(CourseDetailActionCreator.changeIndex());
      break;
    case ActionType.collection:
      changeCollection(ctx, detail.courseId);
      break;
    case ActionType.feedback:
      Application.router.navigateTo(
        ctx.context,
        Routes.feedback,
        transition: TransitionType.native,
      );
      break;
    default:
  }
}
