import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/router/application.dart';
import 'package:myapp/router/routers.dart';

class FloatWindow {
  static OverlayEntry _overlayEntry;

  static feedback(BuildContext context, String path) {
    _overlayEntry?.remove();
    _overlayEntry = new OverlayEntry(
      builder: (context) {
        return Positioned(
          width: AppSize.width(328),
          bottom: AppSize.height(490),
          right: AppSize.width(24),
          child: Material(
            color: Colors.white.withOpacity(0),
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    top: AppSize.height(36),
                    right: AppSize.width(40),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        AppSize.width(6),
                      ),
                    ),
                    color: const Color(0xFF6F6F70),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(
                          AppSize.width(14),
                          AppSize.width(14),
                          AppSize.width(14),
                          0,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              AppSize.width(6),
                            ),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              AppSize.width(6),
                            ),
                          ),
                          child: Image.file(
                            File(path),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: AppSize.height(173),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Application.router.navigateTo(
                            context,
                            Routes.feedback,
                            transition: TransitionType.native,
                          );
                          _overlayEntry?.remove();
                          _overlayEntry = null;
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: AppSize.height(29),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "assets/images/icn_opinion.png",
                                color: Colors.white,
                                width: AppSize.width(45),
                                height: AppSize.height(45),
                              ),
                              SizedBox(
                                width: AppSize.width(4),
                              ),
                              Text(
                                '反馈问题',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: AppSize.sp(36),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: AppSize.width(33)),
                        color: const Color(0xFFD2D2D2),
                        height: AppSize.height(3),
                      ),
                      InkWell(
                        onTap: () async {
                          await fluwx.share(
                            fluwx.WeChatShareImageModel(
                                image: 'file://$path',
                                thumbnail: 'assets/images/share_thumbnail.png',
                                transaction: 'file://$path',
                                scene: fluwx.WeChatScene.SESSION,
                                description: "图片分享"),
                          );
                          _overlayEntry?.remove();
                          _overlayEntry = null;
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: AppSize.height(29),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "assets/images/icn_share.png",
                                color: Colors.white,
                                width: AppSize.width(45),
                                height: AppSize.height(45),
                              ),
                              SizedBox(
                                width: AppSize.width(4),
                              ),
                              Text(
                                '分享页面',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: AppSize.sp(36),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  width: AppSize.width(60),
                  height: AppSize.width(60),
                  child: InkWell(
                    onTap: () {
                      _overlayEntry?.remove();
                      _overlayEntry = null;
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF6F6F70),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: AppSize.sp(45),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    Overlay.of(context).insert(_overlayEntry);
  }
}
