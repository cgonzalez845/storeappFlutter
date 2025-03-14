import 'package:storeapp/app/core/domain/entity/person_entity.dart';

abstract class RegisterRepository {
  Future<bool> register(PersonEntity personEntity);
}
