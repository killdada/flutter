import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_file_helper/flutter_file_helper.dart';
import 'package:myapp/common/model/course/course.dart';
import 'package:myapp/common/utils/index.dart';
import 'package:rxdart/rxdart.dart';
import 'bloc_provider.dart';
import 'package:path_provider/path_provider.dart';

class DownloadBloc extends BlocBase {
  /*---------------------------------*/

  StreamSubscription progressSubscription;
  List<TaskInfo> taskInfos = [];
  List<TaskInfo> checkedTasks = [];

  List <DownloadTask> downloadTasks = [];

  /*---------------------------------*/

  BehaviorSubject<bool> _empty = BehaviorSubject.seeded(true);

  Sink<bool> get _emptySink => _empty.sink;

  Stream<bool> get emptyStream => _empty.stream;

  /*---------------------------------*/

  BehaviorSubject<bool> _handle = BehaviorSubject.seeded(false);

  Sink<bool> get _handleSink => _handle.sink;

  Stream<bool> get handleStream => _handle.stream;


  BehaviorSubject<List<TaskInfo>> _loadDownload = BehaviorSubject();

  Sink<List<TaskInfo>> get _loadDownloadSink => _loadDownload.sink;

  Stream<List<TaskInfo>> get loadDownloadStream => _loadDownload.stream;

  /*---------------------------------*/

 void pauseAllDownloadTask(){

    taskInfos.forEach((task){

      if(task.status == DownloadTaskStatus.running ||
          task.status == DownloadTaskStatus.enqueued){

        task.status = DownloadTaskStatus.paused;
        FlutterDownloader.pause(taskId: task.taskId);
      }
    });
    _loadDownloadSink.add(taskInfos);
  }

  void listenTasksProgress() {


    FlutterDownloader.registerCallback((id, status, progress,speed) {
//      print(
//          '**************Download task ($id) is in status ($status) and process ($progress)');
      List taksIds = taskInfos.map((task){
        return task.taskId;
      }).toList();
      int index = taksIds.indexOf(id);
      if(taskInfos?.length <= index) return;
      TaskInfo task = taskInfos[index];
      if(AppUtil.isMobileNotAllowsCellularAccess()){
        FlutterDownloader.pause(taskId: id);
        task.status = DownloadTaskStatus.paused;
      }else{
        task.status = status;
      }
      task.progress = progress;
      if(progress >= 100){

        task.status = DownloadTaskStatus.complete;
      }else if(progress == -1){

        task.status = DownloadTaskStatus.failed;
      }
      if(speed >0)
        task.speed = speed;
      _loadDownloadSink.add(taskInfos);
    });
  }

  void loadAllDownloadTasks () async{

    taskInfos.clear();
    downloadTasks = await FlutterDownloader.loadTasks();
    downloadTasks.forEach((task){

      TaskInfo _t = TaskInfo(

        link:task.url
      );
      _t.taskId = task.taskId;
      _t.progress = task.progress;
      _t.status = task.status;
      _t.extra = task.extra;
//      if(task.status == DownloadTaskStatus.running){
//
//        taskInfos.insert(0, _t);
//      }else
      taskInfos.add(_t);
    });
    _loadDownloadSink.add(taskInfos);
    _emptySink.add(taskInfos.isEmpty);
  }

  void setHandle(bool handle) {
    _handleSink.add(handle);
  }

  bool isChecked(TaskInfo task) {
    return checkedTasks.contains(task);
  }

  void setChecked(bool checked, TaskInfo task) {
    if (checked) {
      checkedTasks.add(task);
    } else {
      checkedTasks.remove(task);
    }
  }

  void setAllChecked() {
    checkedTasks.clear();
    checkedTasks.addAll(taskInfos);
    _loadDownloadSink.add(taskInfos);
  }

  void resumeTask (TaskInfo oldTaks) async{

    CourseRecordEntity entity = CourseRecordEntity.fromJson(json.decode(oldTaks.extra));
    List taksIds = taskInfos.map((task){
      return task.taskId;
    }).toList();
    int index = taksIds.indexOf(oldTaks.taskId);
    String taskId = await FlutterDownloader.resume(taskId: oldTaks.taskId);
    TaskInfo task = taskInfos[index];
    task.taskId = taskId;
    task.status = DownloadTaskStatus.enqueued;
    taskInfos.replaceRange(index, index+1, [task]);
    _loadDownloadSink.add(taskInfos);
  }

  void updateTask (TaskInfo oldTaks){

    CourseRecordEntity entity = CourseRecordEntity.fromJson(json.decode(oldTaks.extra));
    List taksIds = taskInfos.map((task){
      return task.taskId;
    }).toList();
    int _index = taksIds.indexOf(oldTaks.taskId);
    requestDownloadTask(_index,oldTaks.link,oldTaks.taskId,entity);
  }

  void requestDownloadTask(int index,String link,String tId,CourseRecordEntity entity) async{

    String  _localPath = (await _findLocalPath()) + '/Download';
    print(_localPath);
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
    CourseRecordEntity newEntity  = CourseRecordEntity(

        author: entity.author,
        imgUrl:entity.imgUrl,
        totalVedioTime: entity.totalVedioTime,
        courseId:entity.courseId,
        cateoryName: entity.cateoryName,
        courseName: entity.courseName,
        desc: entity.desc,
        id: entity.id,
        fileSize: entity.fileSize
    );
    Map<String, String> _extra =  newEntity.toJson();
    //插件默认只能同时下载3个文件，将等待任务保存进db,用户点击或者有任务下载完成的时候，删除db中存在的，将一个新的任务加入下载队列
    FlutterDownloader.remove(taskId: tId);
    String taskId = await FlutterDownloader.enqueue(
      url:link,
//      url:"http://enos.itcollege.ee/~jpoial/allalaadimised/reading/Android-Programming-Cookbook.pdf",
      savedDir : _localPath,
      extra:_extra,
//      showNotification: true, // show download progress in status bar (for Android)
//      openFileFromNotification: true, // click on notification to open downloaded file (for Android)
    );
    TaskInfo task = taskInfos[index];
    task.taskId = taskId;
    task.status = DownloadTaskStatus.enqueued;
    taskInfos.replaceRange(index, index+1, [task]);
   _loadDownloadSink.add(taskInfos);
  }

  Future<String> _findLocalPath() async {
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    if (Platform.isAndroid) {
      Directory dir = Directory('${directory.path}/peiban');
      FileHelper.mkdirs(dir.path);
      return dir.path;
    }
    return directory.path;
  }

  void deleteTask({
    void onData(),
    void onError(String error),
  }) async {
    if (checkedTasks.isEmpty) {
      onError('至少选择一项');
      return;
    }
    for (int i = 0; i < checkedTasks.length; i++) {
      TaskInfo task = checkedTasks[i];
      await FlutterDownloader.remove(taskId: task.taskId, shouldDeleteContent:true);
    }
    checkedTasks.forEach(taskInfos.remove);
    checkedTasks.clear();

    _loadDownloadSink.add(taskInfos);
    _emptySink.add(taskInfos == null || taskInfos.isEmpty);
    if (taskInfos == null || taskInfos.isEmpty) {
      _handleSink.add(false);
    }
  }

  @override
  void dispose() {
    progressSubscription?.cancel();
    _loadDownload.close();
    _empty.close();
    _handle.close();
    super.dispose();
  }
}

class TaskInfo {
  final String link;

  String extra;
  String taskId;
  int progress = 0;
  double speed = 0.0;
  DownloadTaskStatus status = DownloadTaskStatus.undefined;

  TaskInfo({this.link});
}

class ItemHolder {
  final String name;
  final TaskInfo task;

  ItemHolder({this.name, this.task});
}
