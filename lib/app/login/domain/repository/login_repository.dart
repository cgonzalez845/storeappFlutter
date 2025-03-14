import 'package:storeapp/app/login/domain/entity/login_entity.dart';

abstract class LoginRepository {
  Future<bool> login(LoginEntity LoginEntity);
  Future<bool> logout();
}
