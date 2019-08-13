import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class FadeRoute extends PageRoute {
  FadeRoute({
    @required this.pageBuilder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.opaque = false,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
  });

  final WidgetBuilder pageBuilder;

  @override
  final Duration transitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  @override
  final Color barrierColor;

  @override
  final String barrierLabel;

  @override
  final bool maintainState;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) =>
      pageBuilder(context);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: pageBuilder(context),
    );
  }
}

class GalleryPhotoViewWrapper extends StatefulWidget {
  GalleryPhotoViewWrapper(
      {this.loadingChild,
      this.backgroundDecoration,
      this.minScale,
      this.maxScale,
      this.initialIndex,
      @required this.galleryItems,
      this.onBack})
      : pageController = PageController(initialPage: initialIndex);

  final Widget loadingChild;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final List<GalleryExampleItem> galleryItems;
  final void Function(int) onBack;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  int currentIndex;
  @override
  void initState() {
    currentIndex = widget.initialIndex;
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: widget.backgroundDecoration,
          constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height,
          ),
          child: SafeArea(
              top: true,
              child: Stack(
                alignment: Alignment.topLeft,
                children: <Widget>[
                  PhotoViewGallery.builder(
                    scrollPhysics: const BouncingScrollPhysics(),
                    builder: _buildItem,
                    itemCount: widget.galleryItems.length,
                    loadingChild: widget.loadingChild,
                    backgroundDecoration: widget.backgroundDecoration,
                    pageController: widget.pageController,
                    onPageChanged: onPageChanged,
                  ),
                  _navigationBarItem(),
                ],
              ))),
    );
  }

  _navigationBarItem() {
    return Container(
      color: Color(0x55000000),
      height: kToolbarHeight,
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(
              "${currentIndex + 1} / ${widget.galleryItems.length}",
              style: const TextStyle(
                  color: Colors.white, fontSize: 17.0, decoration: null),
            ),
          ),
          IconButton(
            onPressed: () {
              if (widget.onBack != null &&
                  widget.initialIndex != currentIndex) {
                widget.onBack(currentIndex);
              }
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final GalleryExampleItem item = widget.galleryItems[index];
    return PhotoViewGalleryPageOptions(
      imageProvider: NetworkImage(
        item.resource,
      ),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 1.1,
      heroTag: item.id,
    );
  }
}

class GalleryExampleItem {
  GalleryExampleItem({this.id, this.resource});

  final String id;
  final String resource;
}
