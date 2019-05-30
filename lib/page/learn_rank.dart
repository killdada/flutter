import 'package:flutter/material.dart';
import 'package:myapp/widget/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:myapp/widget/list_placeholder.dart';
import 'package:myapp/common/model/learn_rank_item.dart';

class LearnRank extends StatefulWidget {
  final String title;
  LearnRank({@required this.title}) : assert(title != null);

  @override
  _LearnRankState createState() => _LearnRankState();
}

class _LearnRankState extends State<LearnRank> {
  var rankList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context, '${widget.title}'),
      body: _content(),
    );
  }

  Widget _content() {
    if (rankList == null) {
      return Center(
        child: CupertinoActivityIndicator(),
      );
    }
    if (rankList.isEmpty) {
      return ListPlaceholder.empty();
    }
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (BuildContext context, int index) {
        return _renderItem(index, rankList[index]);
      },
    );
  }

  Widget _renderItem(int index, LearnRankItem item) {
    return Text('1');
  }
}
