import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/constant/style.dart';
import 'package:myapp/common/dao/collection_dao.dart';
import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/widget/custom_check_box.dart';
import 'package:myapp/widget/custom_widget.dart';
import 'package:myapp/widget/list_placeholder.dart';
import 'package:myapp/widget/page_wrapper.dart';

class CollectionPage extends StatefulWidget {
  CollectionPage({Key key}) : super(key: key);

  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  List data = [];
  @override
  void initState() {
    super.initState();
    _initData
  }
  void _initData() async {
    var data = await CollectionDao.getMyCollection();
    if (mounted) {
      print('323123${data}');
    }
  }
   

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: '我的收藏',
        trailing: Offstage(
          offstage: data.isEmpty,
          child: CommonCheckBox(
            onChanged: (checked) => {},
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
        ),
      ),
      body: _body(),
    );
  }

  Widget _body({List data}) {
    return Text('11');
  }
}
