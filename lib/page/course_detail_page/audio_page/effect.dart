import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<AudioState> buildEffect() {
  return combineEffects(<Object, Effect<AudioState>>{
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
  });
}

void _dispose(Action action, Context<AudioState> ctx) {
  ctx.state.audioPlayer.dispose();
}

void pause(Context<AudioState> ctx) async {
    int result = await  ctx.state.audioPlayer.pause();
  }

void stop(Context<AudioState> ctx) async {
    int result = await ctx.state.audioPlayer.stop();
    if (result == 1) {
      // success
    }
  }

void resume(Context<AudioState> ctx) async {
    int result = await ctx.state.audioPlayer.resume();
    if (result == 1) {
      // success
    }
  }

void play(Context<AudioState> ctx, String url) async {
    int result = await ctx.state.audioPlayer.play(url);
    if (result == 1) {
      // success
      if (ctx.state.videoEventData.position != null) {
      await  ctx.state.audioPlayer.seek(ctx.state.videoEventData.position);
      }
    }
  }


void seek(Context<AudioState> ctx, Duration time) async {
    int result = await ctx.state.audioPlayer.seek(time);
    if (result == 1) {
      // success
    }
  }

void _init(Action action, Context<AudioState> ctx) {
  if (ctx.state.currentCatalog != null &&ctx.state.currentCatalog.videoUrl != null) {
    play(ctx, ctx.state.currentCatalog.videoUrl);
    ctx.state.audioPlayer.onAudioPositionChanged.listen((Duration  p)  {
      print('Current position: $p');
      ctx.dispatch(AudioActionCreator.changePosition(p));
    });
  }
}
