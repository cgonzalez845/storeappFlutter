
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapp/app/core/data/remote/service/person_service.dart';
import 'package:storeapp/app/core/domain/entity/person_entity.dart';
import 'package:storeapp/app/login/domain/entity/login_entity.dart';
import 'package:storeapp/app/signup/domain/repository/register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final PersonService personService;

  RegisterRepositoryImpl({required this.personService});

  @override
  Future<bool> register(PersonEntity personEntity) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: personEntity.email,
    password: personEntity.password!,
  );
  personEntity.id = credential.user!.uid;
  return personService.add(personEntity.toPersonDataModel());
      
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
    return false;
  }
}
