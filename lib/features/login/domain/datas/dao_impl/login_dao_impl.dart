import 'package:sqflite/sqflite.dart';
import 'package:vici_technical_test/features/login/domain/datas/dao/login_dao.dart';
import 'package:vici_technical_test/features/register/domain/datas/models/user_model.dart';

import '../../../../../core/database/db_provider.dart';
import '../../../../../injection_container.dart';

class LoginDaoImpl extends LoginDao {
  final Database db = sl<Database>();

  @override
  Future<UserModel> findLoginModel(String username, String password) async {
    List<Map<String, Object?>> a = await db.rawQuery(
        "select * from $registerAnggotaTABLE WHERE username = '$username' AND password = '$password'");
    return a.isNotEmpty
        ? a.map((e) => UserModel.fromJson(e)).first
        : UserModel();
  }
}
