import 'dart:io';
import 'package:flutter/material.dart';


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
//   final VideoPlayerGatherController controller;
  final double minHeight;
  final double maxHeight;
//   final Widget appBar;
  final Widget child;

  SliverOpacityHeader({
    // @required this.controller,
    @required this.minHeight,
    @required this.maxHeight,
    // @required this.appBar,
    @required this.child,
  }) : assert(maxHeight > minHeight);

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) =>
      this != oldDelegate;

  @override
  double get maxExtent => maxHeight;

  double get minExtent => minHeight;


  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    double top = 0;
    double opacity = 0;

   
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
        Positioned.fill(
          child: Offstage(
            offstage: true,
            // offstage: controller.isPlaying() || opacity < 0.1,
            child: Container(
              color: const Color(0xFF999999).withOpacity(opacity),
            ),
          ),
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
