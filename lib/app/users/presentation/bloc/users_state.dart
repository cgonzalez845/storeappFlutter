import 'package:storeapp/app/users/presentation/model/user_model.dart';
import 'package:storeapp/app/users/presentation/model/users_model.dart';

sealed class UsersState {
  UsersState({required this.model});

  final UsersModel model;
}

final class UsersEmptyState extends UsersState {
  UsersEmptyState() : super(model: UsersModel(users: []));
  //InitialState({required super.model});
}

final class UsersLoadingState extends UsersState {
  final String message;
  UsersLoadingState({this.message = "Loading..."})
      : super(model: UsersModel(users: []));
}

final class UsersLoadDataState extends UsersState {
  UsersLoadDataState({required super.model});
}

final class UsersUpdateState extends UsersState {
  UsersUpdateState({required super.model});
}

final class UsersSuccessState extends UsersState {
  UsersSuccessState({required super.model});
}

final class UsersErrorState extends UsersState {
  UsersErrorState({required super.model, String? message});
}

final class LogoutState extends UsersState {
  LogoutState() : super(model: UsersModel(users: []));
}
