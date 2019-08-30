import 'package:audioplayers/audioplayers.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/model/course-detail/course_detail_model.dart';
import 'action.dart';
import 'state.dart';

Effect<AudioState> buildEffect() {
  return combineEffects(<Object, Effect<AudioState>>{
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
    AudioAction.onSeekTo: _onSeekTo,
    AudioAction.onChangePlayUrl: _onChangePlayUrl,
    AudioAction.onPause: _onPause,
    AudioAction.onResume: _onResume,
  });
}

void _onPause(Action action, Context<AudioState> ctx) async {
  await ctx.state.audioPlayer.pause();
}

void _onResume(Action action, Context<AudioState> ctx) async {
  await ctx.state.audioPlayer.resume();
}

void _onSeekTo(Action action, Context<AudioState> ctx) async {
  int result = await ctx.state.audioPlayer.seek(action.payload);
  if (result == 1) {
    // 更新位置
    // ctx.dispatch(AudioActionCreator.changePosition(action.payload));
  }
}

void _onChangePlayUrl(Action action, Context<AudioState> ctx) async {
  CatalogsModel catalog = action.payload;
  await play(ctx, catalog.videoUrl);
  ctx.dispatch(AudioActionCreator.changeCurrentCatalog(catalog));
}

void _dispose(Action action, Context<AudioState> ctx) {
  ctx.state.audioPlayer?.dispose();
}

Future play(Context<AudioState> ctx, String url) async {
  print('开始播放音频，当前时间：${ctx.state.videoEventData.position}');
  await ctx.state.audioPlayer.play(
    ctx.state.currentCatalog.videoUrl,
    position: ctx.state.videoEventData.position ?? Duration(seconds: 0),
    stayAwake: true,
  );
}

void seek(Context<AudioState> ctx, Duration time) async {
  int result = await ctx.state.audioPlayer.seek(time);
  if (result == 1) {
    // success
  }
}

void _init(Action action, Context<AudioState> ctx) async {
  if (ctx.state.currentCatalog != null &&
      ctx.state.currentCatalog.videoUrl != null) {
    await play(ctx, ctx.state.currentCatalog.videoUrl);
    ctx.state.audioPlayer.onAudioPositionChanged.listen((Duration p) {
      print('Current player position: $p');
      ctx.dispatch(AudioActionCreator.changePosition(p));
    });
    ctx.state.audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
      print('Current player state: $s');
    });
  }
}
