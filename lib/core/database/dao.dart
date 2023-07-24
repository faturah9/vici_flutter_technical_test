import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../../injection_container.dart';
import '../../utils/model.dart';

abstract class BaseDao<T extends BaseModel?> {
  final Database dbProvider = sl<Database>();
  final String table;

  BaseDao(this.table);

  Future<int?> upsert(T todo) async {
    var result = await dbProvider.insert(table, todo!.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  Future<int?> rawInsert(List<T>? todos) async {
    return await (dbProvider.transaction((txn) async {
      var batch = txn.batch();
      for (var element in todos!) {
        txn.insert(table, element!.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }

      await batch.commit(noResult: true);
    }).catchError((error) {
      if (kDebugMode) {
        print(error);
      }
    }));
  }

  Future deleteAll() async {

    return await dbProvider.transaction((txn) async {
      var batch = txn.batch();
      batch.delete(table);

      await batch.commit(noResult: true);
    }).catchError((error) {
      if (kDebugMode) {
        print(error);
      }
    });
  }

  Future<int?> deleteById(int id) async {

    return await (dbProvider.transaction((txn) async {
      var batch = txn.batch();
      batch.delete(table, where: 'id = ?', whereArgs: [id]);

      await batch.commit(noResult: true);
    }).catchError((error) {
      if (kDebugMode) {
        print(error);
      }
    }));
  }

  Future<List<T>> getAll(
      String tableName, T Function(Map<String, dynamic> json) fromJson,
      {String? orderBy}) async {
    List<Map<String, dynamic>> itemFound =
        await dbProvider.query(tableName, orderBy: orderBy);
    List<T> datas = itemFound.isNotEmpty
        ? itemFound.map((item) => fromJson(item)).toList()
        : [];
    return datas;
  }

  Future<List<T>> getAllNew(T Function(Map<String, dynamic> json) fromJson,
      {String? orderBy}) async {
    List<Map<String, dynamic>> itemFound =
        await dbProvider.query(table, orderBy: orderBy);
    List<T> datas = itemFound.isNotEmpty
        ? itemFound.map((item) => fromJson(item)).toList()
        : [];
    return datas;
  }

  Future<List<T>> getAllSortBy(
      String tableName,
      T Function(Map<String, dynamic> json) fromJson,
      String columnName,
      String sortBy) async {
    List<Map<String, dynamic>> itemFound =
        await dbProvider.query(tableName, orderBy: columnName + " " + sortBy);
    List<T> datas = itemFound.isNotEmpty
        ? itemFound.map((item) => fromJson(item)).toList()
        : [];
    return datas;
  }

  Future<List<T>> getAllBySearch(
      String tableName,
      T Function(Map<String, dynamic> json) fromJson,
      String columnName,
      String value) async {
    List<Map<String, dynamic>> itemFound = await dbProvider
        .rawQuery("select * from $tableName where $columnName like '%$value%'");
    if (kDebugMode) {
      print(itemFound);
    }
    List<T> datas = itemFound.isNotEmpty
        ? itemFound.map((item) => fromJson(item)).toList()
        : [];
    return datas;
  }

  Future<List<T>> getAllByWhere(
      String tableName,
      T Function(Map<String, dynamic> json) fromJson,
      String whereString,
      String whereCondition) async {
    List<Map<String, dynamic>> itemFound = await dbProvider.rawQuery(
        "select * from $tableName where $whereString = '$whereCondition'");
    List<T> datas = itemFound.isNotEmpty
        ? itemFound.map((item) => fromJson(item)).toList()
        : [];
    return datas;
  }

  getSpesifikData(
      String tableName,
      T Function(Map<String, dynamic> json) fromJson,
      String whereString,
      String columnnya,
      String whereCondition) async {
    List<Map<String, dynamic>> itemFound = await dbProvider.rawQuery(
        "select * from $tableName where $whereString = '$whereCondition'");
    var datas = itemFound.isNotEmpty
        ? itemFound.map((item) => item[columnnya]).toList()
        : [];
    return datas.first;
  }

  Future<List<T>> getAllByWhereCostume(String tableName,
      T Function(Map<String, dynamic> json) fromJson, String where) async {
    List<Map<String, dynamic>> itemFound =
        await dbProvider.rawQuery("select * from $tableName where $where");
    List<T> datas = itemFound.isNotEmpty
        ? itemFound.map((item) => fromJson(item)).toList()
        : [];
    return datas;
  }

  Future<int?> getCount() async {
    return Sqflite.firstIntValue(
        await dbProvider.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int?> updateOne(T todo, String columnWhere) async {
    return await (dbProvider.transaction((txn) async {
      var batch = txn.batch();
      batch.update(table, todo!.toJson(), where: columnWhere);

      await batch.commit(noResult: true);
    }).catchError((error) {
      if (kDebugMode) {
        print(error);
      }
    }));
  }
}
