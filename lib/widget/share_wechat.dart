import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:myapp/common/utils/index.dart';
import 'package:fluwx/fluwx.dart';
import 'package:myapp/common/constant/style.dart';
import 'package:myapp/common/utils/appsize.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'dart:ui' as ui;

StreamSubscription<fluwx.WeChatShareResponse> _wxlogin;

class ShareToWeChat extends StatelessWidget {
  final String coverImageUrl;
  final String title;
  final String author;
  ShareToWeChat({this.coverImageUrl, this.title, this.author});

  GlobalKey repaintBoundaryKey = GlobalKey();
  Color _bgColor = Colors.white.withOpacity(0.95);

  Widget build(BuildContext context) {
    _listenWechatShare();
    return Material(
        type: MaterialType.transparency,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.symmetric(
                  horizontal: AppSize.width(121), vertical: AppSize.height(58)),
              height: AppSize.width(69),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Image.asset(
                  'assets/images/icn_popup_close.png',
                  width: AppSize.width(69),
                  height: AppSize.width(69),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            _content(),
            _bottomView(context),
          ],
        ));
  }

  _listenWechatShare() {
    if (_wxlogin != null) _wxlogin.cancel();
    _wxlogin = fluwx.responseFromShare.listen((WeChatShareResponse res) {
      showToast('分享成功！');
      print('微信分享状态:$res');
    });
  }

  Widget _content() {
    return RepaintBoundary(
      key: repaintBoundaryKey,
      child: Container(
        margin: EdgeInsets.only(left: 0, right: 0, bottom: AppSize.height(180)),
        child: AspectRatio(
            aspectRatio: 0.95,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: AppSize.width(121)),
              decoration: BoxDecoration(
                color: _bgColor,
                borderRadius: BorderRadius.all(Dimens.radius_12),
              ),
              child: Column(
                children: <Widget>[
                  _cacheBgImage(coverImageUrl),
                  Container(
                    margin: EdgeInsets.only(
                        left: AppSize.width(43),
                        right: AppSize.width(43),
                        top: AppSize.height(15),
                        bottom: AppSize.height(15)),
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: AppSize.sp(43), color: Color(0xFF4A4A4A)),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(horizontal: AppSize.width(43)),
                    child: Text(
                      author,
                      style: TextStyle(
                          fontSize: AppSize.sp(35), color: Color(0xFFA4A4A4)),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(''), //占位
                  ),
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: <Widget>[
                      Container(
                        child: Image.asset(
                          'assets/images/icn_share_bg.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '长按扫描二维码\n观看精彩课程知识点\n与我一起学习吧',
                            style: TextStyle(
                                fontSize: AppSize.sp(35),
                                color: Color(0xFF4A4A4A),
                                height: 1.3),
                            textAlign: TextAlign.right,
                          ),
                          SizedBox(
                            width: AppSize.width(52),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: AppSize.height(20)),
                            child: QrImage(
                              data: 'http://www.baidu.com',
                              size: AppSize.width(300),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
    ;
  }

  Widget _bottomView(BuildContext context) {
    return Container(
//      aspectRatio: 3.29,
      child: Container(
        margin: EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: _bgColor,
          borderRadius: BorderRadius.horizontal(
              left: Dimens.radius_23, right: Dimens.radius_23),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _shareBarItem('assets/images/icn_wechat.png', "微信", 0, context),
            _shareBarItem('assets/images/icn_group.png', "朋友圈", 1, context),
          ],
        ),
      ),
    );
  }

  _shareBarItemOnTap(int type, BuildContext context) async {
    print("type:$type");
    Navigator.pop(context);

    String _imagePath = await _capturePng(context);
    String _thumbnail = 'assets/images/share_thumbnail.png';
    fluwx.share(fluwx.WeChatShareImageModel(
        image: _imagePath,
        thumbnail: _thumbnail,
        transaction: _imagePath,
        scene:
            type == 0 ? fluwx.WeChatScene.SESSION : fluwx.WeChatScene.TIMELINE,
        description: "这是一张图片"));
  }

  Future<String> _capturePng(BuildContext context) async {
    RenderRepaintBoundary boundary =
        repaintBoundaryKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path + '/share_wx.png';
    String tempPath2 = tempDir.path + '/share_wx1.png';

    bool hasExisted = await Directory(tempPath).exists();
    if (hasExisted) {
      File(tempPath).delete();
    }
    File(tempPath).writeAsBytesSync(pngBytes);
    return 'file://$tempPath';
  }

  Widget _cacheBgImage(String uri) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(AppSize.width(12.0)),
        topRight: Radius.circular(AppSize.width(12.0)),
      ),
      child: AspectRatio(
          aspectRatio: 1.7,
          child: CachedNetworkImage(
            fit: BoxFit.fitWidth,
            imageUrl: uri,
            placeholder: (context, url) => CupertinoActivityIndicator(),
            width: double.infinity,
//          height: double.infinity,
          )),
    );
  }

  Widget _shareBarItem(
      String assetName, String text, int index, BuildContext context) {
    return GestureDetector(
      onTap: () {
        _shareBarItemOnTap(index, context);
      },
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: AppSize.height(42), bottom: AppSize.height(20)),
              child: Image.asset(
                assetName,
                width: AppSize.width(72),
                height: AppSize.width(72),
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: AppSize.height(42)),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: AppSize.sp(37), color: Color(0xFF666666)),
                maxLines: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<T> customShowDialog<T>({
  @required
      BuildContext context,
  bool barrierDismissible = true,
  @Deprecated(
      'Instead of using the "child" argument, return the child from a closure '
      'provided to the "builder" argument. This will ensure that the BuildContext '
      'is appropriate for widgets built in the dialog.')
      Widget child,
  WidgetBuilder builder,
}) {
  assert(child == null || builder == null);
  assert(debugCheckHasMaterialLocalizations(context));

  final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      final Widget pageChild = child ?? Builder(builder: builder);
      return SafeArea(
        top: true,
        bottom: false, //***
        child: Builder(builder: (BuildContext context) {
          return theme != null
              ? Theme(data: theme, child: pageChild)
              : pageChild;
        }),
      );
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 150),
    transitionBuilder: _buildMaterialDialogTransitions,
  );
}

Widget _buildMaterialDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return FadeTransition(
    opacity: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: child,
  );
}
