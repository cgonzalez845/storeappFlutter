import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapp/app/login/domain/entity/login_entity.dart';
import 'package:storeapp/app/login/domain/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  @override
  Future<bool> login(LoginEntity loginEntity) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginEntity.email, password: loginEntity.password);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool("L0gin", true);
      return true;
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

  @override
  Future<bool> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }
}
