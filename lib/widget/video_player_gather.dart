import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_video_player/flutter_video_player.dart';
import 'package:myapp/common/constant/style.dart';
import 'package:myapp/common/utils/appsize.dart';

/// Value
class VideoPlayerGatherValue {
  /// Header滑动透明度
  final double opacity;

  /// 是否为音频模式
  final bool isAudio;

  /// 是否为普通模式
  final bool isNormal;

  /// 封面图URL
  final String coverUrl;

  /// 视频播放进度
  final Duration position;

  VideoPlayerGatherValue({
    this.opacity = 0,
    this.isAudio = false,
    this.isNormal = false,
    this.coverUrl = '',
    this.position = Duration.zero,
  });

  VideoPlayerGatherValue.empty() : this();

  VideoPlayerGatherValue copyWith({
    double opacity,
    String coverUrl,
    bool isAudio,
    bool isNormal,
    Duration position,
  }) {
    return VideoPlayerGatherValue(
      opacity: opacity ?? this.opacity,
      coverUrl: coverUrl ?? this.coverUrl,
      isAudio: isAudio ?? this.isAudio,
      isNormal: isNormal ?? this.isNormal,
      position: position ?? this.position,
    );
  }

  @override
  String toString() {
    return 'VideoPlayerGatherValue{opacity: $opacity, isAudio: $isAudio, isNormal: $isNormal, coverUrl: $coverUrl, position: $position}';
  }
}

/// Controller
class VideoPlayerGatherController {
  VideoPlayerController _playerController;

  VideoPlayerGatherValue _gatherValue = VideoPlayerGatherValue();

  StreamController<VideoPlayerGatherValue> _streamController =
      StreamController.broadcast();
  Sink<VideoPlayerGatherValue> _valueSink;
  Stream<VideoPlayerGatherValue> valueStream;

  void _playerListener() {
    _gatherValue = _gatherValue.copyWith(
      position: _playerController.value.position,
    );
    _valueSink.add(_gatherValue);
  }

  VideoPlayerGatherController() {
    _valueSink = _streamController.sink;
    valueStream = _streamController.stream;

    _playerController = VideoPlayerController()..addListener(_playerListener);
  }

  void dispose() {
    _streamController?.close();
    _playerController?.removeListener(_playerListener);
    _playerController?.dispose();
  }

  static VideoPlayerGatherController of(BuildContext context) {
    final provider =
        context.inheritFromWidgetOfExactType(_VideoPlayerGatherProvider)
            as _VideoPlayerGatherProvider;
    return provider.controller;
  }

  void updateOpacity(double opacity) {
    _gatherValue = _gatherValue.copyWith(opacity: opacity);
    _valueSink.add(_gatherValue);
  }

  void setCoverUrl(String url) {
    _playerController.setWidgets(
      overlay: _VideoPlayerGatherProvider(
        controller: this,
        child: _OverlayWidget(url),
      ),
    );

    _gatherValue = _gatherValue.copyWith(coverUrl: url);
    _valueSink.add(_gatherValue);
  }

  void setAudio(bool audio) {
    _gatherValue = _gatherValue.copyWith(isAudio: audio);
    _valueSink.add(_gatherValue);
  }

  void setNormal(bool normal) {
    _gatherValue = _gatherValue.copyWith(isNormal: normal);
    _valueSink.add(_gatherValue);
  }

  void setDataSource(String dataSource) {
    _playerController.setDataSource(dataSource);
  }

  void setTitle(String title) {
    _playerController.setTitle(title);
  }

  void play() {
    _playerController.play();
  }

  void pause() {
    _playerController.pause();
  }

  void seekTo(Duration moment) {
    _playerController.seekTo(moment);
  }

  bool isPlaying() {
    return _playerController.value.isPlaying;
  }

  bool isFullScreen() {
    return _playerController.value.isFullScreen;
  }

  Duration watchDuration() {
    return _playerController.watchDuration;
  }
}

/// Provider
class _VideoPlayerGatherProvider extends InheritedWidget {
  final VideoPlayerGatherController controller;

  _VideoPlayerGatherProvider({
    Key key,
    @required this.controller,
    @required Widget child,
  })  : assert(controller != null),
        assert(child != null),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_VideoPlayerGatherProvider oldWidget) =>
      controller != oldWidget.controller;
}

class SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar widget;
  final Color color;

  const SliverTabBarDelegate(this.widget, {this.color})
      : assert(widget != null);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: widget,
      color: color,
    );
  }

  @override
  bool shouldRebuild(SliverTabBarDelegate oldDelegate) {
    return false;
  }

  @override
  double get maxExtent => widget.preferredSize.height;

  @override
  double get minExtent => widget.preferredSize.height;
}

/// Header
class SliverOpacityHeader extends SliverPersistentHeaderDelegate {
  final VideoPlayerGatherController controller;
  final double minHeight;
  final double maxHeight;
  final Widget appBar;
  final Widget child;

  SliverOpacityHeader({
    @required this.controller,
    @required this.minHeight,
    @required this.maxHeight,
    @required this.appBar,
    @required this.child,
  }) : assert(maxHeight > minHeight);

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) =>
      this != oldDelegate;

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  // double get minExtent => controller.isPlaying() ? maxHeight : minHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    double top = 0;
    double totalOffset = maxExtent - minExtent;
    double opacity = 0;

    // if (controller.isPlaying()) {
    //   top = 0;
    // } else {
    //   if (shrinkOffset >= totalOffset) {
    //     top = -totalOffset;
    //     opacity = 1.0;
    //   } else {
    //     top = -shrinkOffset;
    //     opacity = shrinkOffset / totalOffset;
    //   }
    // }

    // controller.updateOpacity(opacity);

    final topPadding = MediaQuery.of(context).padding.top;

    return Stack(
      overflow: Overflow.clip,
      children: <Widget>[
        Positioned(
          top: Platform.isIOS ? top : top / 2,
          left: 0,
          right: 0,
          height: maxExtent,
          child: Container(
            color: Colors.black,
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: topPadding),
            child: child,
          ),
        ),
        // Positioned.fill(
        //   child: Offstage(
        //     offstage: controller.isPlaying() || opacity < 0.1,
        //     child: Container(
        //       color: const Color(0xFF999999).withOpacity(opacity),
        //     ),
        //   ),
        // ),
        Container(
          padding: EdgeInsets.only(top: topPadding),
          alignment: Alignment.topCenter,
          child: appBar,
        ),
      ],
    );
  }
}

/// StickerHeader
class SliverStickerHeader extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;

  SliverStickerHeader({
    @required this.height,
    @required this.child,
  })  : assert(height >= 0),
        assert(child != null);

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) =>
      this != oldDelegate;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Center(
      child: child,
    );
  }
}

/// AppBar
class _VideoAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VideoPlayerGatherController controller =
        VideoPlayerGatherController.of(context);

    return StreamBuilder(
      stream: controller.valueStream,
      initialData: VideoPlayerGatherValue.empty(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final _value = snapshot.data;
        return Container(
          height: Dimens.appBarHeight,
          padding: EdgeInsets.symmetric(horizontal: AppSize.width(10.0)),
          child: Stack(
            children: <Widget>[
              Center(
                child: Row(
                  children: <Widget>[
                    _backBth(context),
                    Spacer(
                      flex: 1,
                    ),
                    _frequencyBtn(controller, _value),
                    _transformBtn(controller, _value),
                  ],
                ),
              ),
              Center(
                child: _playBtn(controller, _value),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _backBth(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Padding(
        padding: EdgeInsets.all(AppSize.width(29.0)),
        child: Image.asset(
          'assets/images/icn_nav_back.png',
          width: AppSize.width(29.0),
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _frequencyBtn(
    VideoPlayerGatherController controller,
    VideoPlayerGatherValue value,
  ) {
    return AnimatedOpacity(
      opacity: value.opacity >= 1 ? 0.0 : 1.0,
      duration: const Duration(milliseconds: 300),
      child: InkWell(
        onTap: () {
          if (value.opacity >= 1) return;
          controller.setAudio(!value.isAudio);
        },
        child: Padding(
          padding: EdgeInsets.all(AppSize.width(29.0)),
          child: Image.asset(
            'assets/images/icn_frequency.png',
            width: AppSize.width(63.0),
            color: value.isAudio ? Colors.pinkAccent : Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _transformBtn(
    VideoPlayerGatherController controller,
    VideoPlayerGatherValue value,
  ) {
    return AnimatedOpacity(
      opacity: value.opacity >= 1 ? 0.0 : 1.0,
      duration: const Duration(milliseconds: 300),
      child: InkWell(
        onTap: () {
          if (value.opacity >= 1) return;
          controller.setNormal(!value.isNormal);
        },
        child: Padding(
          padding: EdgeInsets.all(AppSize.width(29.0)),
          child: Image.asset(
            'assets/images/icn_transform.png',
            width: AppSize.width(63.0),
            color: value.isNormal ? Colors.pinkAccent : Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _playBtn(
    VideoPlayerGatherController controller,
    VideoPlayerGatherValue value,
  ) {
    return AnimatedOpacity(
      opacity: value.opacity < 1 ? 0.0 : 1.0,
      duration: const Duration(milliseconds: 300),
      child: InkWell(
        onTap: () {
          if (value.opacity < 1) return;
          controller.play();
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: AppSize.width(2.0),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                AppSize.width(86.0),
              ),
            ),
          ),
          width: AppSize.width(230.0),
          height: AppSize.height(86.0),
          alignment: Alignment.center,
          padding: EdgeInsets.only(
            right: AppSize.width(20.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: AppSize.sp(70.0),
              ),
              SizedBox(
                width: AppSize.width(10.0),
              ),
              Text(
                '播放',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: AppSize.sp(40.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// _OverlayWidget
class _OverlayWidget extends StatelessWidget {
  final String coverUrl;

  _OverlayWidget(this.coverUrl);

  @override
  Widget build(BuildContext context) {
    VideoPlayerGatherController controller =
        VideoPlayerGatherController.of(context);

    return StreamBuilder(
      stream: controller.valueStream,
      initialData: VideoPlayerGatherValue(coverUrl: coverUrl),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final _value = snapshot.data;
        final isAudio = _value.isAudio && !controller.isFullScreen();
        bool hideCover = false;
        if (isAudio) {
          hideCover = false;
        } else {
          hideCover = controller.isPlaying() ||
              controller.watchDuration() > Duration.zero;
        }

        return Stack(
          children: <Widget>[
            AnimatedOpacity(
              opacity: hideCover ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: SizedBox.expand(
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: _value.coverUrl,
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: !isAudio ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: Center(
                child: SpinKitRipple(
                  color: Colors.red,
                  size: double.infinity,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// VideoScaffold
class VideoScaffold extends StatefulWidget {
  final VideoPlayerGatherController controller;
  final PreferredSize header;
  final Widget body;

  VideoScaffold({
    @required this.controller,
    this.header,
    this.body,
  }) : assert(controller != null);

  @override
  _VideoScaffoldState createState() {
    return _VideoScaffoldState();
  }
}

class _VideoScaffoldState extends State<VideoScaffold> {
  bool _isPlaying = false;

  void _listener(VideoPlayerGatherValue value) {
    var playing = widget.controller.isPlaying();
    if (_isPlaying != playing) {
      if (!_isPlaying && playing) {
        setState(() {});
      }
      _isPlaying = playing;
    }
  }

  @override
  void initState() {
    widget.controller.valueStream.listen(_listener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: _VideoPlayerGatherProvider(
          controller: widget.controller,
          child: NestedScrollView(
            headerSliverBuilder: _headerSliverBuilder,
            body: widget.body ?? Container(),
          ),
        ),
      ),
    );
  }

  List<Widget> _headerSliverBuilder(
    BuildContext context,
    bool innerBoxIsScrolled,
  ) {
    final topPadding = MediaQuery.of(context).padding.top;

    List<Widget> widgets = [
      SliverPersistentHeader(
        pinned: true,
        delegate: SliverOpacityHeader(
          controller: widget.controller,
          minHeight: Dimens.appBarHeight + topPadding,
          maxHeight: MediaQuery.of(context).size.width * 0.62 + topPadding,
          appBar: _VideoAppBar(),
          child: SampleVideoPlayer(widget.controller._playerController),
        ),
      ),
    ];
    if (widget.header != null) {
      widgets.add(
        SliverPersistentHeader(
          pinned: true,
          delegate: SliverStickerHeader(
            height: widget.header.preferredSize.height,
            child: widget.header,
          ),
        ),
      );
    }

    return widgets;
  }
}
