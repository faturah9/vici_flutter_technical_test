import 'package:intl/intl.dart';
import 'package:vici_technical_test/features/register/domain/datas/models/user_model.dart';
import 'package:vici_technical_test/features/register/domain/repository/register_repository.dart';

import '../../../../injection_container.dart';
import '../datas/dao/register_dao.dart';
import '../datas/dao_impl/register_dao_impl.dart';

class RegisterRepositoryImpl extends RegisterRepository {
  final RegisterDao registerDao = sl<RegisterDaoImpl>();

  RegisterRepositoryImpl();

  @override
  Future<UserModel> getUserData(String? username) async {
    UserModel registerAnggotaModel =
        await registerDao.findRegisterModel(username!);
    return registerAnggotaModel;
  }

  @override
  Future<UserModel> sendRegisterData(String? name, String? username,
      String? password, String? numberPhone) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    UserModel userModel = UserModel(
      nama: name,
      username: username,
      password: password,
      noHp: numberPhone,
      createdAt: formattedDate,
      updatedAt: formattedDate,
    );

    int? registerModelId = await registerDao.upsert(userModel);
    userModel.id = registerModelId;
    return userModel;
  }
}
