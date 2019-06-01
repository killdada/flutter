/* https://www.jianshu.com/p/78fe79648596 
 * 给页面包裹一层FutureBuilder
 * 页面有请求的时候使用，显示不同的状态
*/
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:myapp/widget/list_placeholder.dart';

class PageWrapper {
  static pageBuilder(Future future, pageBuildFunc, {isListPage = true}) {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('');
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.active:
            return Text('');
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Text(
                '${snapshot.error}',
                style: TextStyle(color: Colors.red),
              );
            } else if (isListPage) {
              // 列表
              try {
                if (snapshot.data['list'].isEmpty) {
                  // 列表没有数据
                  return ListPlaceholder.empty();
                }
                return pageBuildFunc(data: snapshot.data['list']);
              } catch (e) {
                return Text(
                  '列表没有返回对应的数据结构',
                  style: TextStyle(color: Colors.red),
                );
              }
            }
            return pageBuildFunc(data: snapshot.data);
        }
      },
    );
  }
}
