import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/app/login/domain/use_case/login_use_case.dart';
import 'package:storeapp/app/login/presentation/bloc/login_event.dart';
import 'package:storeapp/app/login/presentation/bloc/login_state.dart';
import 'package:storeapp/app/login/presentation/model/login_form_model.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  //LoginBloc(super.initialState);
  LoginBloc({required this.loginUseCase}) : super(LoginInitialState()) {
    on<EmailChangedEvent>(_emailChangedEvent);
    on<PasswordChangedEvent>(_passwordChangedEvent);
    on<SubmitEvent>(_submitEvent);

    //_loginUseCase = LoginUseCase();
  }

  //FutureOr<void> _emailChangedEvent(EmailChangedEvent event, Emitter<LoginState> emit) {
  void _emailChangedEvent(EmailChangedEvent event, Emitter<LoginState> emit) {
    /*final oldData = state.model;
    final newData = LoginFormModel(email: event.email, password: state.model.password);
    final newState = EventState(model: newData);*/

    final newState = LoginEventState(
      model: state.model.copyWith(email: event.email),
    );

    emit(newState);
  }

  //FutureOr<void> _passwordChangedEvent(PasswordChangedEvent event, Emitter<LoginState> emit) {
  void _passwordChangedEvent(
    PasswordChangedEvent event,
    Emitter<LoginState> emit,
  ) {
    final newState = LoginEventState(
      model: state.model.copyWith(password: event.password),
    );

    emit(newState);
  }

  //FutureOr<void> _submitEvent(SubmitEvent event, Emitter<LoginState> emit) {
  Future<void> _submitEvent(SubmitEvent event, Emitter<LoginState> emit) async {
    late final LoginState newState;

    try {
      final bool result = await loginUseCase.invoke(state.model);

      if (result) {
        newState = LoginSuccessState(model: state.model);
      } else {
        newState = LoginErrorState(
            model: state.model, message: "Ha ocurrido un error inesperado");
      }
    } catch (e) {
      newState = LoginErrorState(
          model: state.model, message: "Ha ocurrido un error inesperado");
      emit(newState);
    }

    emit(newState);
  }
}
