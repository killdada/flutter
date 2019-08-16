import 'package:myapp/common/constant/constant.dart';

class VideoEvent {
  // 播放模式，视频，音频
  final PlayType playType;
  // 课程是普通模式还是简洁模式
  final VideoModel videoModel;
  VideoEvent({this.playType, this.videoModel});
}
