import 'package:storeapp/app/login/presentation/model/login_form_model.dart';

sealed class LoginState {
  LoginState({required this.model});

  final LoginFormModel model;
}

final class LoginInitialState extends LoginState {
  LoginInitialState() : super(model: LoginFormModel(email: "", password: ""));
  //InitialState({required super.model});
}

final class LoginEventState extends LoginState {
  LoginEventState({required super.model});
}

final class LoginSuccessState extends LoginState {
  LoginSuccessState({required super.model});
}

final class LoginErrorState extends LoginState {
  LoginErrorState({required super.model, String? message});
}
