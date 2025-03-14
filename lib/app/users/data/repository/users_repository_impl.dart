import 'package:storeapp/app/core/data/remote/dto/person_data_model.dart';
import 'package:storeapp/app/core/data/remote/service/person_service.dart';
import 'package:storeapp/app/users/domain/repository/users_repository.dart';

class UsersRepositoryImpl implements UsersRepository {
  final PersonService personService;

  UsersRepositoryImpl({required this.personService});

  @override
  Future<List<PersonDataModel>> getUsers() async {
    final List<PersonDataModel> persons = [];
    try {
      final response = await personService.getAll();
      for (var element in response) {
        persons.add(element);
      }
    } catch (e) {
      throw (Exception(e));
    }

    return persons;
  }

}
