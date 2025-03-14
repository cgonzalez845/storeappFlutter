import 'package:storeapp/app/login/data/repository/login_repository_impl.dart';
import 'package:storeapp/app/login/domain/repository/login_repository.dart';
import 'package:storeapp/app/login/presentation/model/login_form_model.dart';

class LoginUseCase {
  final LoginRepository loginRepository;
  LoginUseCase({required this.loginRepository});
/*
  LoginUseCase() {
    _loginRepository = LoginRepositoryImpl();
  }*/

  Future<bool> invoke(LoginFormModel LoginFormModel) {
    final data = LoginFormModel.toEntity();
    try {
      return loginRepository.login(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
