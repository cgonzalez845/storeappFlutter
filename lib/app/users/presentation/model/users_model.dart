import 'package:storeapp/app/users/presentation/model/user_model.dart';

final class UsersModel {
  final List<UserModel> users;

  UsersModel({required this.users});

  UsersModel copyWith({required List<UserModel> users}) {
    return UsersModel(users: users);
  }
}
