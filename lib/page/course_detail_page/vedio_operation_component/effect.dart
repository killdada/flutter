import 'package:fish_redux/fish_redux.dart';
import 'package:fluro/fluro.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/common/constant/constant.dart';
import 'package:myapp/common/dao/collection_dao.dart';
import 'package:myapp/common/model/course-detail/index.dart';
import 'package:myapp/common/utils/data_utils.dart';
import 'package:myapp/page/course_detail_page/action.dart';
import 'package:myapp/page/course_detail_page/audio_page/action.dart';
import 'package:myapp/router/application.dart';
import 'package:myapp/router/routers.dart';
import 'package:myapp/widget/share_wechat.dart';
import 'action.dart';
import 'state.dart';

Effect<VedioOperationState> buildEffect() {
  return combineEffects(<Object, Effect<VedioOperationState>>{
    VedioOperationAction.onClickItem: _onClickItem,
  });
}

void changeCollection(Context<VedioOperationState> ctx, int id) async {
  bool logined = await DataUtils.isLogin();
  PlayType pageType = ctx.state.pageType;
  bool isAudio = pageType == PlayType.audio;

  if (!logined) {
    Fluttertoast.showToast(msg: '请先登录');
  } else if (!ctx.state.collected) {
    // 取消收藏
    try {
      await CollectionDao.addCollection(id);
      if (isAudio) {
        ctx.dispatch(AudioActionCreator.changeCollect());
      } else {
        ctx.dispatch(CourseDetailActionCreator.changeCollect());
      }
      Fluttertoast.showToast(msg: '收藏成功');
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  } else {
    // 添加收藏
    try {
      await CollectionDao.deleCollection([id]);
      if (isAudio) {
        ctx.dispatch(AudioActionCreator.changeCollect());
      } else {
        ctx.dispatch(CourseDetailActionCreator.changeCollect());
      }
      Fluttertoast.showToast(msg: '取消收藏成功');
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}

void clickDown(Context<VedioOperationState> ctx) {
  PlayType pageType = ctx.state.pageType;
  bool isAudio = pageType == PlayType.audio;
  if (isAudio) {
  } else {
    ctx.dispatch(CourseDetailActionCreator.changeIndex());
  }
}

void shareToWechat(CourseDetailModel detail, Context<VedioOperationState> ctx) {
  if (detail != null &&
      detail.imgUrl != null &&
      detail.courseName != null &&
      detail.author != null) {
    customShowDialog(
        context: ctx.context,
        barrierDismissible: false,
        builder: (context) {
          return ShareToWeChat(
            coverImageUrl: detail.imgUrl,
            title: detail.courseName,
            author: detail.author,
          );
        });
  }
}

void _onClickItem(Action action, Context<VedioOperationState> ctx) {
  Map data = action.payload;
  ActionType type = data['type'];
  CourseDetailModel detail = data['detail'];
  switch (type) {
    case ActionType.share:
      shareToWechat(detail, ctx);
      break;
    case ActionType.download:
      clickDown(ctx);
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
