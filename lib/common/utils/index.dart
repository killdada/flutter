import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/common/utils/appsize.dart';
import 'package:flutter_file_helper/flutter_file_helper.dart';
import 'package:myapp/common/utils/data_utils.dart';
import 'package:sprintf/sprintf.dart';

class AppUtil {
  static ConnectivityResult connectivityStatus;
  static Connectivity connectivity;
  static bool allowsCelluarAccess = false;
  static AppUtil _singleton;

  static Future<AppUtil> init() async {
    if (_singleton == null) {
      var singleton = AppUtil();
      connectivity = Connectivity();
      DataUtils.initAppFirstInstall();
      _singleton = singleton;
    }
    return _singleton;
  }

  static bool isWifi() {
    if (connectivityStatus == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static bool isMobile() {
    if (connectivityStatus == ConnectivityResult.mobile) {
      return true;
    }
    return false;
  }

  static bool isMobileNotAllowsCellularAccess() {
    if (isMobile() && !allowsCelluarAccess) {
      return true;
    }
    return false;
  }

  static updateCellularAccess(bool access) {
    allowsCelluarAccess = access;
  }

  static updateConnectivityStatus(ConnectivityResult result) {
    if (connectivityStatus == result) return;
    connectivityStatus = result;
  }
}

class StorageUtil {
  static String convert(double size) {
    size ??= 0;

    int kb = 1024;
    int mb = kb * 1024;
    int gb = mb * 1024;

    if (size >= gb) {
      return sprintf('%.2fG', [size / gb]);
    } else if (size > mb) {
      return sprintf('%.2fM', [size / mb]);
    } else if (size > kb) {
      return sprintf('%.2fK', [size / kb]);
    } else {
      return '${size}B';
    }
  }

  static Future<String> getAvailable() async {
    double totalSize = await FileHelper.getAvailableSize();
    return convert(totalSize);
  }

  static Future<String> getUsed() async {
    double totalSize = await FileHelper.getTotalSize();
    double freeSize = await FileHelper.getAvailableSize();
    double size = totalSize - freeSize;
    return convert(size);
  }

  static Future<Map<String, String>> storage() async {
    return {
      'used': await getUsed(),
      'available': await getAvailable(),
    };
  }
}

showToast(String msg, {int time}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: Platform.isIOS ? ToastGravity.CENTER : ToastGravity.BOTTOM,
      timeInSecForIos: time ?? 1,
      backgroundColor: Color(0xFF999999),
      textColor: Colors.white,
      fontSize: AppSize.sp(40));
}

showCelluarTips(BuildContext context, bool isDownloading,
    [Function confirmAction]) {
  showDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text(
            isDownloading ? '正在使用非WiFi网络，下载将产生流量费用' : '正在使用非WiFi网络，播放将产生流量费用'),
//        content: Text(isDownloading?'流量下载':'流量播放'),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text('取消'),
            onPressed: () {
              AppUtil.updateCellularAccess(false);
              return Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            child: Text(isDownloading ? '流量下载' : '流量播放'),
            onPressed: () {
              Navigator.pop(context);
              AppUtil.updateCellularAccess(true);
              if (confirmAction != null) confirmAction();
            },
          ),
        ],
      );
    },
  );
}
