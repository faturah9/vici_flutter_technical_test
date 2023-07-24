import '../../../../../core/database/dao.dart';
import '../../../../../core/database/db_provider.dart';
import '../models/user_model.dart';

abstract class RegisterDao extends BaseDao<UserModel> {
  RegisterDao() : super(registerAnggotaTABLE);

  Future<UserModel> findRegisterModel(String username);
}
