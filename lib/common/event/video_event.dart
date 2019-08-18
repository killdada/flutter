import 'package:myapp/common/constant/constant.dart';
import 'package:myapp/common/model/course-detail/course_detail_model.dart';

class VideoEvent {
  // 播放模式，视频，音频
  final PlayType playType;
  // 课程是普通模式还是简洁模式
  final VideoModel videoModel;
  // 切换的时候的播放位置
  Duration position; 
  VideoEvent({this.playType, this.videoModel, this.position});
}


class ChangePlayUrl {
  final String url;
  Duration position; 
  ChangePlayUrl(this.url, { this.position } );
}

class ChangePptIndex {
  final PptModel ppt;
  bool neewSeekTo = true; // 下面的JumpPPtWithTime如果会改变index那么这个时候不需要跳转到指定时间
  ChangePptIndex(this.ppt, this.neewSeekTo);
}

class JumpPPtWithTime {
  final int time;
  JumpPPtWithTime(this.time);
}