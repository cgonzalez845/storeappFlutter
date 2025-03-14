import 'package:storeapp/app/signup/domain/repository/register_repository.dart';
import 'package:storeapp/app/signup/presentation/model/sign_up_model.dart';

class RegisterUseCase {
  final RegisterRepository registerRepository;
  RegisterUseCase({required this.registerRepository});

  Future<bool> invoke(SignUpModel registerFormModel) {
    final data = registerFormModel.toEntity();
    try {
      return registerRepository.register(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
