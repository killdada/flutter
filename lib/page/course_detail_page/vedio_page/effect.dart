import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/services.dart';
import 'package:myapp/common/dao/course_detail_dao.dart';
import 'package:myapp/common/event/event_bus.dart';
import 'package:myapp/common/event/video_event.dart';
import 'package:myapp/common/utils/data_utils.dart';
import 'action.dart';
import 'state.dart';

Effect<VedioState> buildEffect() {
  return combineEffects(<Object, Effect<VedioState>>{
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
  });
}

void _dispose(Action action, Context<VedioState> ctx) async {
  VedioState state = ctx.state;
  try {
    bool islogin = await DataUtils.isLogin();
    if (islogin) {
      int watchtimer = state.videoController.watchDuration.inSeconds;
      print('视频播放时，观看时长：${watchtimer}');
      if (watchtimer > 0) {
        await CourseDetailDao.reportLearningTime(state.courseId, watchtimer);
      }
    }
  } catch (e) {}
  state.chewieController.pause();
  state.videoController.dispose();
  state.chewieController.dispose();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
}

void _init(Action action, Context<VedioState> ctx) {
 MyEventBus.event.on<ChangePlayUrl>().listen((event) {
         print('播放器视频链接改变：${event.url}');
      ctx.dispatch(VedioActionCreator.changeVideo(event.url));
    });
}
