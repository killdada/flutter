import 'dart:async';
import 'dart:ui';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:myapp/common/blocs/bloc_index.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:myapp/common/constant/style.dart';
import 'package:myapp/common/model/course/course.dart';
import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/common/utils/date_utils.dart';
import 'package:myapp/common/utils/index.dart';
import 'package:myapp/widget/custom_check_box.dart';
import 'package:myapp/widget/custom_expansion_tile.dart';
import 'package:myapp/widget/custom_image_view.dart';
import 'package:myapp/widget/custom_widget.dart';
import 'package:myapp/widget/list_placeholder.dart';

const int MEGABYTE = 1024 * 1024;

class DownloadPage extends StatefulWidget {
  @override
  _DownloadPageState createState() {
    return _DownloadPageState();
  }
}

class _DownloadPageState extends State<DownloadPage>
    with WidgetsBindingObserver {
  DownloadBloc downloadBloc;
  int _curDownloadingCount = 0;
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  ConnectivityResult _connectivityStatus;

  @override
  void initState() {
    downloadBloc = BlocProvider.of(context);
    Timer(const Duration(milliseconds: 500), () {
      downloadBloc.loadAllDownloadTasks();
    });
    downloadBloc.listenTasksProgress();
    WidgetsBinding.instance.addObserver(this);
    _connectivityListen();
    super.initState();
  }

  @override
  void dispose() {
    FlutterDownloader.registerCallback(null);
    WidgetsBinding.instance.removeObserver(this);
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("--" + state.toString());
    switch (state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        break;
      case AppLifecycleState.resumed: // 应用程序可见，前台
        //刷新界面
//        downloadBloc.loadAllDownloadTasks();
        break;
      case AppLifecycleState.paused: // 应用程序不可见，后台
        break;
      case AppLifecycleState.suspending: // 申请将暂时暂停
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: CommonScaffold(
          backgroundColor: Colors.white,
          appBar: CommonAppBar(
            title: '我的下载',
            trailing: StreamBuilder(
              stream: downloadBloc.emptyStream,
              initialData: true,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Offstage(
                  offstage: snapshot.data,
                  child: CommonCheckBox(
                    onChanged: (checked) => downloadBloc.setHandle(checked),
                    checkBoxBuilder: (bool checked) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(
                          0,
                          AppSize.height(20.0),
                          AppSize.width(46.0),
                          AppSize.height(20.0),
                        ),
                        child: Text(
                          checked ? '取消' : '管理',
                          style: TextStyles.style,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          body: StreamBuilder(
            stream: downloadBloc.loadDownloadStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              List<TaskInfo> tasks = snapshot.data;
              if (tasks == null) {
                return Center(
                  child: CupertinoActivityIndicator(),
                );
              }
              if (tasks.isEmpty) {
                return ListPlaceholder.empty();
              }

              _curDownloadingCount = 0;
              final List<TaskInfo> downloadingTasks = [];
              final List<TaskInfo> downloadedTasks = [];
              tasks.forEach((task) {
                if (task.status == DownloadTaskStatus.running)
                  _curDownloadingCount++;
                if (task.status != DownloadTaskStatus.complete) {
                  if (task.progress > 0) {
                    downloadingTasks.insert(0, task);
                  } else
                    downloadingTasks.add(task);
                } else {
                  downloadedTasks.add(task);
                }
              });

              return Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: ListView(
                      children: <Widget>[
                        _downloadingLayout(downloadingTasks), //
                        Divider(
                          height: Dimens.divider,
                          color: const Color(0xFFDDDDDD),
                        ),
                        _downloadedLayout(downloadedTasks),
                      ],
                    ),
                  ),
                  _bottomLayout(),
                ],
              );
            },
          ),
        ));
  }

  Widget _downloadingLayout(List<TaskInfo> tasks) {
    if (tasks.isEmpty) return SizedBox(height: 0);
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            top: AppSize.height(26.0),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppSize.width(46.0),
          ),
          child: Row(
            children: <Widget>[
              Text(
                '正在下载',
                style: TextStyles.style.copyWith(
                  fontSize: Dimens.sp_40,
                ),
              ),
              SizedBox(
                width: AppSize.width(6.0),
              ),
              Container(
                width: AppSize.width(46.0),
                height: AppSize.width(46.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFF73E4D),
                ),
                child: Center(
                  child: Text(
                    '${tasks.length}',
                    style: TextStyle(
                      fontSize: AppSize.sp(33.0),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        ExpandTile(
          title: '展开全部下载',
          titlePadding: EdgeInsets.only(
            bottom: AppSize.height(30.0),
          ),
          children: tasks.map((task) {
            return _downloadItem(
              task: task,
              index: tasks.indexOf(task),
              infoWidget: Container(
//                color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 0),
                      child: Offstage(
                        offstage: task.status == DownloadTaskStatus.running
                            ? false
                            : true,
                        child: Text(
                          '${StorageUtil.convert(task.speed)}/s',
                          style: TextStyles.style2.copyWith(
                            color: Colours.blue,
                          ),
                        ),
                      ),
                    ),
                    Offstage(
                      offstage: task.status == DownloadTaskStatus.enqueued
                          ? false
                          : true,
                      child: Text(
                        "等待下载",
                        style: TextStyles.style2.copyWith(
                          color: Colours.blue,
                        ),
                      ),
                    ),
                    Offstage(
                      offstage: task.status == DownloadTaskStatus.paused
                          ? false
                          : true,
                      child: Text(
                        '暂停中',
                        style: TextStyles.style2.copyWith(
                          color: Colours.lightGray,
                        ),
                      ),
                    ),
                    Offstage(
                      offstage: task.status == DownloadTaskStatus.failed ||
                              task.status == DownloadTaskStatus.canceled
                          ? false
                          : true,
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/images/icn_attention.png',
                            width: AppSize.width(35.0),
                          ),
                          SizedBox(
                            width: AppSize.width(9.0),
                          ),
                          Text('重试',
                              style: TextStyles.style2.copyWith(
                                color: Colours.lightRed,
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              progressWidget: Container(
                margin: EdgeInsets.only(
                  top: AppSize.height(24.0),
                ),
                height: AppSize.height(6.0),
                child: LinearProgressIndicator(
                  value: task.progress.toDouble() / 100.0,
                  backgroundColor: const Color(0xFFF4F5F7),
                  valueColor: AlwaysStoppedAnimation(Colours.blue),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _downloadedLayout(List<TaskInfo> tasks) {
    if (tasks.isEmpty) return SizedBox(height: 0);
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(
            top: AppSize.height(26.0),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppSize.width(46.0),
          ),
          child: Text(
            '已下载',
            style: TextStyles.style.copyWith(
              fontSize: Dimens.sp_40,
            ),
          ),
        ),
        Column(
          children: tasks.map((task) {
            return _downloadItem(task: task, index: tasks.indexOf(task));
          }).toList(),
        ),
      ],
    );
  }

  Widget _downloadItem({
    TaskInfo task,
    int index,
    Widget infoWidget,
    Widget progressWidget,
  }) {
    final taskToJson = json.decode(task.extra);
    CourseRecordEntity course = CourseRecordEntity.fromJson(taskToJson);
    return GestureDetector(
      onTap: () {
        _downloadingItemOnTap(index, task, course);
      },
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSize.width(46.0),
          vertical: AppSize.height(29.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
              stream: downloadBloc.handleStream,
              initialData: false,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Offstage(
                  offstage: !snapshot.data,
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: AppSize.width(25.0),
                    ),
                    child: ImageCheckBox(
                      value: downloadBloc.isChecked(task),
                      onChanged: (checked) =>
                          downloadBloc.setChecked(checked, task),
                    ),
                  ),
                );
              },
            ),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomImageView.square(
                    path: course.imgUrl ?? '',
                    size: AppSize.width(228.0),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(left: AppSize.width(37.0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${course.courseName}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.style
                                .copyWith(fontSize: Dimens.sp_45),
                          ),
                          SizedBox(
                            height: AppSize.height(10.0),
                          ),
                          Text(
                            course.author,
                            style: TextStyles.style2,
                          ),
                          Row(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/icn_time.png',
                                width: AppSize.width(35.0),
                              ),
                              SizedBox(
                                width: AppSize.width(9.0),
                              ),
                              Expanded(
                                flex: 4,
                                child: Text(
                                  '${DateUtil.formatTimeString(course.totalVedioTime)}',
                                  style: TextStyles.style2,
                                ),
                              ),
                              Image.asset(
                                'assets/images/icn_filesize.png',
                                width: AppSize.width(35.0),
                              ),
                              SizedBox(
                                width: AppSize.width(9.0),
                              ),
                              Expanded(
                                flex: 4,
                                child: Text(
                                  StorageUtil.convert(
                                      double.parse(course.fileSize)),
                                  style: TextStyles.style2,
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: infoWidget ?? SizedBox(height: 0),
                              ),
                            ],
                          ),
                          progressWidget ?? SizedBox(height: 0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _bottomLayout() {
    return Stack(
      children: <Widget>[
        Container(
          height: AppSize.height(58.0),
          color: const Color(0xFFF4F5F7),
          child: Center(
            child: FutureBuilder(
              future: StorageUtil.storage(),
              initialData: {},
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                var storage = snapshot.data;
                return RichText(
                  text: TextSpan(
                    text: '已使用',
                    style: TextStyle(
                      fontSize: Dimens.sp_30,
                      color: Colours.textFirst,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: storage['used'],
                        style: TextStyle(color: Colours.blue),
                      ),
                      TextSpan(
                        text: '，可用空间',
                      ),
                      TextSpan(
                        text: storage['available'],
                        style: TextStyle(color: Colours.blue),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        StreamBuilder(
          stream: downloadBloc.handleStream,
          initialData: false,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Offstage(
              offstage: !snapshot.data,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSize.width(46.0),
                  vertical: AppSize.height(30.0),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFEEEEEE),
                      blurRadius: 8.0,
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: handleAction(
                        text: '全选',
                        textColor: Colours.textFirst,
                        onTap: () => downloadBloc.setAllChecked(),
                      ),
                    ),
                    SizedBox(
                      width: AppSize.width(32.0),
                    ),
                    Expanded(
                      flex: 1,
                      child: handleAction(
                        text: '删除',
                        textColor: const Color(0xFFF73E4D),
                        onTap: () {
                          downloadBloc.deleteTask(
                            onData: () => showToast('删除成功'),
                            onError: (error) => showToast(error),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  _downloadingItemOnTap(
      int index, TaskInfo task, CourseRecordEntity course) async {
    if (task.status == DownloadTaskStatus.complete) {
      final taskToJson = json.decode(task.extra);
      CourseRecordEntity course = CourseRecordEntity.fromJson(taskToJson);
      // Router.appRouter.navigateTo(
      //   context,
      //   '${Routes.courseDetail}?courseId=${course.courseId}&recordCatalogId=${course.id}',
      //   transition: TransitionType.cupertino,
      // );
      return;
    }
    if (AppUtil.isMobileNotAllowsCellularAccess()) {
      showCelluarTips(
          context, true, () => _downloadItemAction(index, task, course));
      return;
    }
    _downloadItemAction(index, task, course);
  }

  _downloadItemAction(int index, TaskInfo task, CourseRecordEntity course) {
    print('index : $index');
    if (_curDownloadingCount == 3) {
      if (task.status == DownloadTaskStatus.failed ||
          task.status == DownloadTaskStatus.canceled) {
        downloadBloc.updateTask(task);
      } else if (task.status == DownloadTaskStatus.paused) {
        downloadBloc.resumeTask(task);
      } else {
        showToast("同时下载个数为3，请耐心等待");
        print('同时可下载最大个数为3，请等待任务下载完成');
      }
      return;
    } else if (task.status == DownloadTaskStatus.paused && task.progress > 3) {
      downloadBloc.resumeTask(task);
    } else if (task.status != DownloadTaskStatus.running) {
      downloadBloc.updateTask(task);
    } else {
      print('已经在下载队列，无需再次下载');
    }
  }

  handleAction({
    String text,
    Color textColor,
    GestureTapCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: AppSize.height(100.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              AppSize.width(14.0),
            ),
          ),
          border: Border.all(
            color: const Color(0xFFDDDDDD),
            width: Dimens.divider,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyles.style.copyWith(
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  _connectivityListen() {
    _connectivitySubscription = AppUtil.connectivity.onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (_connectivityStatus != result) {
        if (AppUtil.isMobileNotAllowsCellularAccess()) {
          downloadBloc.pauseAllDownloadTask();
        }
      }
      _connectivityStatus = result;
    });
  }
}
