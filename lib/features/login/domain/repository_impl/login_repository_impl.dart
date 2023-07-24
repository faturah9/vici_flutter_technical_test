import '../../../../injection_container.dart';
import '../../../register/domain/datas/dao/register_dao.dart';
import '../../../register/domain/datas/dao_impl/register_dao_impl.dart';
import '../../../register/domain/datas/models/user_model.dart';
import '../datas/dao/login_dao.dart';
import '../datas/dao_impl/login_dao_impl.dart';
import '../repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDao loginDao = sl<LoginDaoImpl>();

  @override
  Future<UserModel> login(String username, String password) async {
    UserModel loginModel = await loginDao.findLoginModel(username, password);

    return loginModel;
  }
}
