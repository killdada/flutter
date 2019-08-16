import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/model/course-detail/course_detail_model.dart';
import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/page/course_detail_page/action.dart';
import 'package:myapp/widget/carousel_slider.dart';
import 'package:myapp/widget/photo_view.dart';

Widget _cacheBgImage(String uri) {
  return SizedBox(
      child: CachedNetworkImage(
    fit: BoxFit.cover,
    imageUrl: uri,
    placeholder: (context, url) => CupertinoActivityIndicator(),
    width: double.infinity,
    height: double.infinity,
  ));
}

_photoViewPage(
    Map<String, dynamic> state, Dispatch dispatch, ViewService viewService) {
  List<GalleryExampleItem> _urlList = [];
  List<PptModel> ppt = state['list'];
  int pptIndex = state['index'];

  ppt.map((entity) {
    GalleryExampleItem _item =
        GalleryExampleItem(id: entity.url ?? "", resource: entity.url ?? "");
    _urlList.add(_item);
  }).toList();
  return GalleryPhotoViewWrapper(
    galleryItems: _urlList,
    backgroundDecoration: const BoxDecoration(
      color: Colors.black,
    ),
    initialIndex: pptIndex,
    loadingChild: Center(
      child: CupertinoActivityIndicator(),
    ),
    onBack: (int index) {
      dispatch(CourseDetailActionCreator.changePptIndex(index));
    },
  );
}

Widget buildView(
    Map<String, dynamic> state, Dispatch dispatch, ViewService viewService) {
  List<PptModel> list = state['list'];
  List<Widget> _images = [];
  int pptIndex = state['index'];
  list.forEach((PptModel item) {
    String _uri = item.url;
    dynamic _image = _cacheBgImage(_uri);
    _images.add(_image);
    print('<<${item.timeStart}>>');
  });

 final basicSlider = CarouselSlider(
     items: _images,
     height: AppSize.height(380.0),
     autoPlay: false,
     enableInfiniteScroll: false,
     enlargeCenterPage: true,
     viewportFraction: 1.0,
     aspectRatio: 16 / 9,
     //   initialPage: pptIndex, 有问题，目前还没修复，默认还是从0开始
     onPageChanged: (index) {
       dispatch(CourseDetailActionCreator.changePptIndex(index));
     });

 return Container(
   padding: EdgeInsets.symmetric(
     vertical: AppSize.height(10.0),
     horizontal: AppSize.width(36.0),
   ),
   child: Column(
     children: [
       GestureDetector(
         child: basicSlider,
         onTap: () {
           Navigator.push(viewService.context,
               FadeRoute(pageBuilder: (context) {
             return _photoViewPage(state, dispatch, viewService);
           }));
         },
       ),
       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
         IconButton(
           icon: Image.asset(
             'assets/images/Icon_last_pre.png',
             width: AppSize.width(70),
             height: AppSize.width(70),
           ),
           onPressed: () => basicSlider.previousPage(
             duration: Duration(milliseconds: 300),
             curve: Curves.linear,
           ),
         ),
         Text(
           '课程PPT ${pptIndex + 1}/${_images.length}',
           style: TextStyle(
             fontSize: AppSize.sp(32),
             color: Color(0xFF666666),
           ),
         ),
         IconButton(
           icon: Image.asset(
             'assets/images/Icon_next_pre.png',
             width: AppSize.width(70),
             height: AppSize.width(70),
           ),
           onPressed: () => basicSlider.nextPage(
             duration: Duration(milliseconds: 300),
             curve: Curves.linear,
           ),
         ),
       ]),
     ],
   ),
 );
}
