import 'package:storeapp/app/signup/presentation/model/sign_up_model.dart';

sealed class SignupState {
  SignupState({required this.model});

  final SignUpModel model;
}

final class SignUpInitialState extends SignupState {
  SignUpInitialState()
      : super(
            model: SignUpModel(
                id: "", name: "", identification: "", email: "", password: ""));
  //InitialState({required super.model});
}

final class SignUpEventState extends SignupState {
  SignUpEventState({required super.model});
}

final class RegisterSuccessState extends SignupState {
  RegisterSuccessState({required super.model});
}

final class RegisterErrorState extends SignupState {
  RegisterErrorState({required super.model, String? message});
}
