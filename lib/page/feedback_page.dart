import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/common/constant/style.dart';
import 'package:myapp/common/dao/feedback_dao.dart';
import 'package:myapp/common/model/upload_model.dart';
import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/widget/clear_cache_color.dart';
import 'package:myapp/widget/custom_check_box.dart';
import 'package:myapp/widget/custom_image_view.dart';
import 'package:myapp/widget/custom_widget.dart';
import 'package:myapp/widget/loading_dialog.dart';
import 'package:image_picker/image_picker.dart';


class FeedbackPage extends StatefulWidget {
  FeedbackPage({Key key}) : super(key: key);

  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final double _horizontalPadding = AppSize.width(40.0);
  final List<String> questions = const <String>[
    '声音太小',
    '播放卡顿',
    '视频不完整',
    '缺少注释',
    '其他问题',
  ];

  List<String> questionSelects = [];

  List<UploadModel> uploadData = [];

  String questionInput = '';

  void showToast(String msg) {
    Fluttertoast.showToast(msg: msg);
  }

  void checkedQuestion(String question, bool checked) {
    if (checked) {
      if (!questionSelects.contains(question)) {
        questionSelects.add(question);
      }
    } else {
      questionSelects.remove(question);
    }
  }

  void updateQuestionInput(String input) {
    questionInput = input;
  }

  void addFeedback() async {
    if (questionInput.isEmpty) {
      showToast('请描述你遇到的问题');
      return;
    }
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return LoadingDialog(
            text: '正在提交',
          );
        });
    try {
      Map<String, dynamic> params = {
        'title': questionSelects.join(','),
        'content': questionInput,
        'imgs': uploadData.map((entity) => entity.mediaId).toList().toString(),
      };
      await FeedbackDao.addFeedback(params);
      showToast('提交成功');
      Navigator.pop(context);
      Timer(const Duration(milliseconds: 200), () {
        Navigator.pop(context);
      });
    } catch (error) {
      print('添加反馈失败:$error');
      showToast('提交失败');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AutoHideKeyboardWidget(context, _scaffold());
  }

  Widget _scaffold() {
    return CommonScaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: '意见反馈',
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      color: Color.fromRGBO(247, 247, 250, 1),
      child: LayoutBuilder(
        builder: (_, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: _main(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _main() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          color: Colors.white,
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: _horizontalPadding,
            vertical: AppSize.height(20.0),
          ),
          child: RichText(
            text: TextSpan(
              text: '请描述你遇到的问题',
              style: TextStyles.style.copyWith(
                fontSize: Dimens.sp_32,
                color: Color(0xFF333333),
              ),
              children: [
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: const Color(0xFFFF3B30),
                  ),
                ),
              ],
            ),
          ),
        ),
        _questionOptions(),
        _questionContent(),
        SizedBox(
          height: AppSize.height(23.0),
        ),
        Container(
          color: Colors.white,
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: _horizontalPadding,
            vertical: AppSize.height(29.0),
          ),
          child: Text(
            '添加图片 (最多3张)',
            style: TextStyles.style.copyWith(
              fontSize: Dimens.sp_32,
              color: Color(0xFF333333),
            ),
          ),
        ),
        _questionImages(),
        Spacer(
          flex: 1,
        ),
        InkWell(
          onTap: addFeedback,
          child: Container(
            margin: EdgeInsets.fromLTRB(
              _horizontalPadding,
              AppSize.height(90.0),
              _horizontalPadding,
              AppSize.height(70.0),
            ),
            height: AppSize.height(80.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Dimens.radius_15,
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colours.blue,
                  Colours.blueLight,
                ],
              ),
            ),
            child: Text(
              '提交反馈',
              style: TextStyle(
                color: Colors.white,
                fontSize: Dimens.sp_36,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _questionOptions() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: _horizontalPadding,
        vertical: AppSize.height(10.0),
      ),
      child: Wrap(
        spacing: AppSize.width(20.0),
        runSpacing: AppSize.width(20.0),
        children: questions.map((question) {
          return CommonCheckBox(
            onChanged: (checked) => checkedQuestion(question, checked),
            checkBoxBuilder: (bool checked) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSize.width(14.0),
                  vertical: AppSize.height(8.0),
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: checked ? Colours.blue : Colours.textThird,
                    width: Dimens.divider,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      AppSize.width(5.0),
                    ),
                  ),
                ),
                child: Text(
                  question,
                  style: TextStyle(
                    fontSize: Dimens.sp_28,
                    color: checked ? Colours.blue : Color(0xFF666666),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _questionContent() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: _horizontalPadding,
        vertical: AppSize.height(29.0),
      ),
      child: Stack(
        children: <Widget>[
          ClearCacheColor(
            child: TextField(
              maxLength: 100,
              maxLines: 7,
              style: TextStyles.style.copyWith(
                fontSize: Dimens.sp_32,
              ),
              decoration: InputStyles.inputDecoration.copyWith(
                hintText: '描述详细的问题',
                contentPadding: EdgeInsets.symmetric(),
                hintStyle: TextStyle(
                  color: Color(0xFFBBBBBB),
                  fontSize: Dimens.sp_32,
                ),
              ),
              onChanged: (input) => updateQuestionInput(input),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Text(
              '${questionInput.length}/100',
              style: TextStyle(
                color: Color(0xFF999999),
                fontSize: Dimens.sp_24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future _getImage() async {
    hideKeyboard(context);
    try {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        FeedbackDao.uploadFile(
          image,
          onSuccess: (UploadModel entity) {
            uploadData.add(entity);
            setState(() {
              uploadData = uploadData;
            });
          },
          onStart: () => showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return LoadingDialog(
                  text: '正在上传',
                );
              }),
          onError: (error) => showToast(error),
          onDone: () => Navigator.pop(context),
        );
      }
    } catch (e) {}
  }

  Widget _questionImages() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        _horizontalPadding,
        0,
        _horizontalPadding,
        AppSize.height(29.0),
      ),
      child: _uploadWrapper(),
    );
  }

  Widget _uploadWrapper() {
    final List<Widget> items = [];
    final Size clearSize = Size.square(AppSize.width(30.0));
    final Size imageSize = Size.square(AppSize.width(140.0));

    if (uploadData != null && uploadData.isNotEmpty) {
      uploadData.forEach((entity) {
        items.add(
          SizedBox(
            width: imageSize.width + clearSize.width / 2,
            height: imageSize.height + clearSize.height / 2,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: clearSize.height / 2,
                  child: GestureDetector(
                    onTap: () {
                      // uploadData.remove(entity);
                    },
                    child: CustomImageView.square(
                      path: entity.mediaUrl,
                      borderRadius: BorderRadius.all(
                        Radius.circular(0),
                      ),
                      size: imageSize.width,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      uploadData.remove(entity);
                      setState(() {
                        uploadData = uploadData;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF3B30),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: Dimens.divider,
                        ),
                      ),
                      padding: EdgeInsets.all(AppSize.width(2.0)),
                      child: Icon(
                        Icons.clear,
                        color: Colors.white,
                        size: clearSize.width,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
    }

    if (items == null || items.length < 3) {
      items.add(InkWell(
        onTap: _getImage,
        child: Container(
          margin: EdgeInsets.only(top: clearSize.height / 2),
          width: imageSize.width,
          height: imageSize.height,
          color: const Color(0xFFF8F8F8),
          child: Icon(
            Icons.add,
            size: AppSize.sp(90.0),
            color: const Color(0xFFDDDDDD),
          ),
        ),
      ));
    }

    return Wrap(
      spacing: AppSize.width(20.0),
      runSpacing: AppSize.width(20.0),
      children: items,
    );
  }
}
