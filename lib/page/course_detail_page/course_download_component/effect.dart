import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_file_helper/flutter_file_helper.dart';
import 'package:myapp/common/model/course-detail/index.dart';
import 'package:myapp/common/model/course/course.dart';
import 'package:myapp/common/utils/index.dart';
import 'package:myapp/page/course_detail_page/action.dart';
import 'package:myapp/router/application.dart';
import 'package:myapp/router/routers.dart';
import 'action.dart';
import 'state.dart';

import 'package:path_provider/path_provider.dart';

Effect<CourseDownloadState> buildEffect() {
  return combineEffects(<Object, Effect<CourseDownloadState>>{
    Lifecycle.initState: _init,
    CourseDownloadAction.onClickItem: _onClickItem,
    CourseDownloadAction.onDownloadItem: _onDownloadItem,
  });
}

void _init(Action action, Context<CourseDownloadState> ctx) {
  _flutterDownloadCallbackListen(ctx);
  _loadAllDownloadTaskFromSQL(ctx);
  _connectivityListen(ctx);
}

_flutterDownloadCallbackListen(Context<CourseDownloadState> ctx) {
  FlutterDownloader.registerCallback((id, status, progress, speed) {
    final taskCatalog = ctx.state.courseDetail.catalogs
        .firstWhere((catalogs) => catalogs.taskId == id);
    print(
        'Download task ($id) is in status ($status) and process ($progress), taskstatus:${taskCatalog.status} ');
    if (taskCatalog == null) return;
    int index = ctx.state.courseDetail.catalogs
        .indexWhere((item) => item.catalogId == taskCatalog.catalogId);
    if (AppUtil.isMobileNotAllowsCellularAccess()) {
      FlutterDownloader.pause(taskId: id);
      taskCatalog.status = DownloadTaskStatus.paused;
    } else if (taskCatalog.status != status) {
      taskCatalog.status = status;
    }
    if (progress >= 100) {
      taskCatalog.status = DownloadTaskStatus.complete;
    } else if (progress == -1) {
      taskCatalog.status = DownloadTaskStatus.failed;
    }
    ctx.dispatch(
        CourseDetailActionCreator.changeCatalogTask(index, taskCatalog));
  });
}

DownloadTask _getDownloadItemeRevanceTask(
    int catalogId, Context<CourseDownloadState> ctx) {
  DownloadTask _t;
  List records = ctx.state.tasks.map((task) {
    final extra = json.decode(task.extra);
    final recordId = extra["id"];
    return recordId;
  }).toList();
  String cid = catalogId.toString();
  if (records.contains(cid)) {
    int index = records.indexOf(cid);
    DownloadTask task = ctx.state.tasks[index];
    _t = task;
  }
  return _t;
}

_loadAllDownloadTaskFromSQL(Context<CourseDownloadState> ctx) async {
  List<DownloadTask> tasks = await FlutterDownloader.loadTasks();
  ctx.dispatch(CourseDetailActionCreator.changeCatalogTasks(tasks));
  for (int i = 0; i < ctx.state.courseDetail.catalogs.length; i++) {
    CatalogsModel _catalog = ctx.state.courseDetail.catalogs[i];
    DownloadTask task = _getDownloadItemeRevanceTask(_catalog.catalogId, ctx);
    _catalog.status = task?.status;
    _catalog.taskId = task?.taskId;
    ctx.dispatch(CourseDetailActionCreator.changeCatalogTask(i, _catalog));
  }
}

_connectivityListen(Context<CourseDownloadState> ctx) {
  StreamSubscription<ConnectivityResult> connectivitySubscription = AppUtil
      .connectivity.onConnectivityChanged
      .listen((ConnectivityResult result) {
    if (ctx.state.connectivityStatus != result) {
      if (AppUtil.isMobileNotAllowsCellularAccess()) {
        ctx.state.tasks.forEach((task) {
          if (task.status == DownloadTaskStatus.running ||
              task.status == DownloadTaskStatus.enqueued) {
            FlutterDownloader.pause(taskId: task.taskId);
          }
        });
      }
    }
    ctx.dispatch(CourseDetailActionCreator.changeConnectivityStatus(result));
  });
  ctx.dispatch(CourseDetailActionCreator.changeConnectivitySubscription(
      connectivitySubscription));
}

void _onClickItem(Action action, Context<CourseDownloadState> ctx) {
  int type = action.payload;
  if (type == 0) {
    ctx.dispatch(CourseDetailActionCreator.changeIndex());
  } else if (type == 1) {
    if (AppUtil.isMobileNotAllowsCellularAccess()) {
      showCelluarTips(ctx.context, true, _downloadAllItemAction(ctx));
      return;
    }
    _downloadAllItemAction(ctx);
  } else if (type == 2) {
    Application.router.navigateTo(ctx.context, Routes.downLoad).then((_) {
      // 下载管理页面重置了监听
      _flutterDownloadCallbackListen(ctx);
      // 从下载页面返回时更新页面
      _loadAllDownloadTaskFromSQL(ctx);
    });
  }
}

_downloadAllItemAction(Context<CourseDownloadState> ctx) {
  List<CatalogsModel> catalogs = ctx.state.courseDetail.catalogs;
  for (int i = 0; i < catalogs.length; i++) {
    CatalogsModel catalog = catalogs[i];
    if (catalog.status == null) {
      catalog.status = DownloadTaskStatus.enqueued;
      ctx.dispatch(CourseDetailActionCreator.changeCatalogTask(i, catalog));
      downloadTaskEnqueue(
        ctx.state.courseDetail.courseId,
        ctx.state.courseDetail.imgUrl,
        ctx.state.courseDetail?.author,
        catalog,
        i,
        ctx,
      );
    }
  }
}

void _onDownloadItem(Action action, Context<CourseDownloadState> ctx) {
  int index = action.payload;
  CatalogsModel catalog = ctx.state.courseDetail.catalogs[index];
  catalog.status = DownloadTaskStatus.enqueued;
  ctx.dispatch(CourseDetailActionCreator.changeCatalogTask(index, catalog));
  downloadTaskEnqueue(
    ctx.state.courseDetail.courseId,
    ctx.state.courseDetail.imgUrl,
    ctx.state.courseDetail?.author,
    catalog,
    index,
    ctx,
  );
}

void downloadTaskEnqueue(int courseId, String imageUrl, String author,
    CatalogsModel catalogs, int index, Context<CourseDownloadState> ctx) async {
  String _localPath = (await _findLocalPath()) + '/Download';
  print(_localPath);
  final savedDir = Directory(_localPath);
  bool hasExisted = await savedDir.exists();
  if (!hasExisted) {
    savedDir.create();
  }
  CourseRecordEntity entity = CourseRecordEntity(
      author: author,
      imgUrl: imageUrl,
      totalVedioTime: catalogs.playTime,
      courseId: "$courseId",
      cateoryName: catalogs.catalogName,
      courseName: catalogs.catalogName,
      desc: catalogs.catalogDesc,
      id: "${catalogs.catalogId}",
      fileSize: "${catalogs.videoByteSize}");
  Map<String, String> _extra = entity.toJson();
  print('****_extra:$_extra');
  if (catalogs.taskId != null) {
    //插件默认只能同时下载3个文件，将等待任务保存进db,用户点击或者有任务下载完成的时候，删除db中存在的，将一个新的任务加入下载队列
    FlutterDownloader.remove(
        taskId: catalogs.taskId, shouldDeleteContent: true);
  }
  String taskId = await FlutterDownloader.enqueue(
    url: catalogs.videoUrl,
//        url:"http://enos.itcollege.ee/~jpoial/allalaadimised/reading/Android-Programming-Cookbook.pdf",
    savedDir: _localPath,
    extra: _extra,
//      showNotification: true, // show download progress in status bar (for Android)
//      openFileFromNotification: true, // click on notification to open downloaded file (for Android)
  );
  catalogs.taskId = taskId;
  ctx.dispatch(CourseDetailActionCreator.changeCatalogTask(index, catalogs));
}

Future<String> _findLocalPath() async {
  final directory = Platform.isAndroid
      ? await FileHelper.getExternalStorageDirectory()
      : await getApplicationDocumentsDirectory();
  if (Platform.isAndroid) {
    Directory dir = Directory('${directory.path}/peiban');
    FileHelper.mkdirs(dir.path);
    return dir.path;
  }
  return directory.path;
}
