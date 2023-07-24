// import 'package:sqflite/sqflite.dart';
// import 'package:vici_technical_test/features/register/domain/datas/models/user_model.dart';
//
// import '../../../../../core/database/dao.dart';
// import '../../../../../core/database/db_provider.dart';
// import '../../../../../injection_container.dart';
//
// class RegisterDao extends BaseDao<UserModel> {
//   final Database db = sl<Database>();
//
//   RegisterDao() : super(registerAnggotaTABLE);
//
//   Future<UserModel> findRegisterModel(String username) async {
//     List<Map<String, Object?>> a = await db.rawQuery(
//         "select * from $registerAnggotaTABLE WHERE username = $username");
//
//     return a.isNotEmpty
//         ? a.map((e) => UserModel.fromJson(e)).first
//         : UserModel();
//   }
// }

import 'package:sqflite/sqflite.dart';
import 'package:vici_technical_test/features/register/domain/datas/dao/register_dao.dart';
import 'package:vici_technical_test/features/register/domain/datas/models/user_model.dart';

import '../../../../../core/database/dao.dart';
import '../../../../../core/database/db_provider.dart';
import '../../../../../injection_container.dart';

class RegisterDaoImpl extends RegisterDao {
  final Database db = sl<Database>();

  @override
  Future<UserModel> findRegisterModel(String username) async {
    List<Map<String, Object?>> a = await db.rawQuery(
        "select * from $registerAnggotaTABLE WHERE username = '$username'");
    return a.isNotEmpty
        ? a.map((e) => UserModel.fromJson(e)).first
        : UserModel();
  }
}
