import 'package:storeapp/app/login/data/repository/login_repository_impl.dart';
import 'package:storeapp/app/login/domain/repository/login_repository.dart';
import 'package:storeapp/app/login/presentation/model/login_form_model.dart';

class LogoutUseCase {
  final LoginRepository loginRepository;
  LogoutUseCase({required this.loginRepository});
/*
  LogoutUseCase() {
    _loginRepository = LoginRepositoryImpl();
  }*/

  Future<bool> invoke() {
    try {
      return loginRepository.logout();
    } catch (e) {
      throw Exception(e);
    }
  }
}
