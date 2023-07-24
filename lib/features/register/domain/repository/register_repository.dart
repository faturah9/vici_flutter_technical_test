import 'package:vici_technical_test/features/register/domain/datas/models/user_model.dart';

abstract class RegisterRepository {
  Future<UserModel> sendRegisterData(
    String? name,
    String? username,
    String? password,
    String? numberPhone,
  );

  Future<UserModel> getUserData(String? username);
}
