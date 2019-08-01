import 'dart:developer';

import 'package:path/path.dart';
import 'dart:async';

// import 'package:flutter/foundation.dart';
import 'sql_provider.dart';
import 'package:sqflite/sqflite.dart';

class SearchHistoryDb extends BaseDbProvider {
  final String name = 'history';

  final String columnId = "_id";
  final String columnValue = "value";
  final String columnDate = "date";

  int id;
  String value;
  String date;

  SearchHistoryDb();

  Map<String, dynamic> toMap(String value, String date) {
    Map<String, dynamic> map = {columnValue: value, columnDate: date};
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  SearchHistoryDb.fromMap(Map map) {
    id = map[columnId];
    value = map[columnValue];
    date = map[columnDate];
  }

  @override
  tableSqlString() {
    return tableBaseString(name, columnId) +
        '''
        $columnValue text not null,
        $columnDate text not null)
      ''';
  }

  @override
  tableName() {
    return name;
  }

  Future loadHistory() async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> maps = await db.query(
      name,
      columns: [columnId, columnValue],
      orderBy: 'date desc',
    );
    return maps;
  }

  Future deleteHistory() async {
    Database db = await getDataBase();
    return await db.delete('history');
  }

  Future addHistory(String value) async {
    Database db = await getDataBase();
    List<Map> list =
        await db.rawQuery('SELECT * FROM history WHERE value = ?', [value]);
    if (list.isNotEmpty) {
      return await db.rawUpdate(
          'UPDATE history SET value = ?, date = ? WHERE value = ?',
          [value, DateTime.now().toString(), value]);
    }
    return await db.execute(
      'REPLACE INTO history(value, date) values(?, ?)',
      [
        value,
        DateTime.now().toString(),
      ],
    );
  }
}
