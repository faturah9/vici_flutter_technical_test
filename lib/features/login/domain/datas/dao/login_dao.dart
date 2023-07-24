import '../../../../../core/database/dao.dart';
import '../../../../../core/database/db_provider.dart';
import '../../../../register/domain/datas/models/user_model.dart';

abstract class LoginDao extends BaseDao<UserModel> {
  LoginDao() : super(registerAnggotaTABLE);

  Future<UserModel> findLoginModel(String username, String password);
}