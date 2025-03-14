import 'package:storeapp/app/home/presentation/model/home_model.dart';
import 'package:storeapp/app/login/presentation/model/login_form_model.dart';

sealed class HomeState {
  HomeState({required this.model});

  final HomeModel model;
}
/*
final class InitialState extends LoginState {
  InitialState() : super(model: LoginFormModel(email: "", password: ""));
  //InitialState({required super.model});
}

final class EventState extends LoginState {
  EventState({required super.model});
}

final class LoginSuccessState extends LoginState {
  LoginSuccessState({required super.model});
}*/

final class HomeEmptyState extends HomeState {
  HomeEmptyState() : super(model: HomeModel(products: []));
  //InitialState({required super.model});
}

final class HomeLoadingState extends HomeState {
  final String message;
  HomeLoadingState({this.message = "Loading..."}) : super(model: HomeModel(products: []));
}

final class HomeLoadDataState extends HomeState {
  HomeLoadDataState({required super.model});
}

final class HomeUpdateState extends HomeState {
  HomeUpdateState({required super.model});
}

final class HomeSuccessState extends HomeState {
  HomeSuccessState({required super.model});
}

final class HomeErrorState extends HomeState {
  HomeErrorState({required super.model, String? message});
}

final class LogoutState extends HomeState {
  LogoutState() : super(model: HomeModel(products: []));
}
