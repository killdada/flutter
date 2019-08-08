import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/widget/custom_widget.dart';

class FeedbackPage extends StatefulWidget {
  FeedbackPage({Key key}) : super(key: key);

  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
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
    );
  }
}
