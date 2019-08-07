/* https://www.jianshu.com/p/78fe79648596
 * 给页面包裹一层FutureBuilder
 * 页面有请求的时候使用，显示不同的状态
*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:myapp/widget/list_placeholder.dart';

class PageWrapper {
  static pageBuilder(Future future, pageBuildFunc) {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('');
          case ConnectionState.waiting:
            return Center(child: CupertinoActivityIndicator());
          case ConnectionState.active:
            return Text('');
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Text(
                '${snapshot.error}',
                style: TextStyle(color: Colors.red),
              );
            }
            if (snapshot.data.length == 0) {
              return ListPlaceholder.empty();
            }
            return pageBuildFunc(data: snapshot.data);
        }
      },
    );
  }
}
