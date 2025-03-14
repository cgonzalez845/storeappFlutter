import 'package:storeapp/app/core/data/remote/dto/person_data_model.dart';
import 'package:storeapp/app/core/domain/entity/person_entity.dart';
import 'package:storeapp/app/core/domain/entity/product_entity.dart';
import 'package:storeapp/app/login/domain/entity/login_entity.dart';

abstract class UsersRepository {
  Future<List<PersonDataModel>> getUsers();
}
