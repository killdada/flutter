import 'dart:developer';
import 'dart:io';

import 'package:myapp/common/http/address.dart';
import 'package:myapp/common/http/http.dart';
import 'package:dio/dio.dart';
import 'package:myapp/common/model/upload_model.dart';
import 'package:image_handle/image_handle.dart';

class FeedbackDao {
  static void uploadFile(
    File file, {
    int index,
    void onStart(),
    void onSuccess(UploadModel data),
    void onError(String error),
    void onDone(),
  }) async {
    onStart();

    Map params = {
      "path": file.path,
      'ratio': Platform.isIOS ? 0.8 : 0.6,
    };
    ImageHandle.imageCompress(params).then((result) async {
      if (result['code'] == 0) {
        try {
          var res = await httpManager.fetch(
            Address.getMaterial(),
            option: Options(
              method: 'post',
              connectTimeout: const Duration(minutes: 2).inMilliseconds,
              receiveTimeout: const Duration(minutes: 2).inMilliseconds,
            ),
            params: FormData.from({
              'media': UploadFileInfo(
                file,
                file.path.substring(file.path.lastIndexOf("/") + 1),
              ),
            }),
          );
          var data = HttpManager.decodeJson(res);

          onSuccess(UploadModel.fromJson(data));
        } catch (error) {
          print('上传文件失败:$error');
          onError('上传失败');
        }
        onDone();
      } else {
        onError('上传失败');
        onDone();
      }
    });
  }

  static Future addFeedback(Map data) async {
    return await httpManager.fetch(
      Address.getFeedback(),
      option: Options(
        method: 'post',
      ),
      params: data,
    );
  }
}
