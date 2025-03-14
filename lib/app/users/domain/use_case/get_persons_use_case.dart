import 'package:storeapp/app/core/data/remote/dto/person_data_model.dart';
import 'package:storeapp/app/users/domain/repository/users_repository.dart';
import 'package:storeapp/app/users/presentation/model/user_model.dart';

class GetPersonsUseCase {
  final UsersRepository usersRepository;
  GetPersonsUseCase({required this.usersRepository});

  Future<List<UserModel>> invoke() async {
    final List<UserModel> users = [];
    try {
      final List<PersonDataModel> data = await usersRepository.getUsers();
      for (var element in data) {
        users.add(element.toUserModel());
      }
      return users;
    } catch (e) {
      throw Exception(e);
    }
  }
}
