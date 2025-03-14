import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/app/signup/domain/use_case/register_use_case.dart';
import 'package:storeapp/app/signup/presentation/bloc/signup_event.dart';
import 'package:storeapp/app/signup/presentation/bloc/signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final RegisterUseCase registerUseCase;

  SignupBloc({required this.registerUseCase}) : super(SignUpInitialState()) {
    on<NameChangedEvent>(_nameChangedEvent);
    on<IdentificationChangedEvent>(_identificationChangedEvent);
    on<ImageChangedEvent>(_imageChangedEvent);
    on<EmailChangedEvent>(_emailChangedEvent);
    on<PasswordChangedEvent>(_passwordChangedEvent);
    on<SubmitEvent>(_submitEvent);
  }

  
  FutureOr<void> _nameChangedEvent(NameChangedEvent event, Emitter<SignupState> emit) {
    final newState = SignUpEventState(
      model: state.model.copyWith(name: event.name),
    );
    emit(newState);
  }

  FutureOr<void> _identificationChangedEvent(IdentificationChangedEvent event, Emitter<SignupState> emit) {
    final newState = SignUpEventState(
      model: state.model.copyWith(identification: event.identification),
    );
    emit(newState);
  }

  FutureOr<void> _imageChangedEvent(ImageChangedEvent event, Emitter<SignupState> emit) {
    final newState = SignUpEventState(
      model: state.model.copyWith(urlImage: event.image),
    );
    emit(newState);
  }

  void _emailChangedEvent(EmailChangedEvent event, Emitter<SignupState> emit) {
    final newState = SignUpEventState(
      model: state.model.copyWith(email: event.email),
    );
    emit(newState);
  }

  void _passwordChangedEvent(
    PasswordChangedEvent event,
    Emitter<SignupState> emit,
  ) {
    final newState = SignUpEventState(
      model: state.model.copyWith(password: event.password),
    );

    emit(newState);
  }

  Future<void> _submitEvent(SubmitEvent event, Emitter<SignupState> emit) async {
    late final SignupState newState;

    try {
      final bool result = await registerUseCase.invoke(state.model);

      if (result) {
        newState = RegisterSuccessState(model: state.model);
      } else {
        newState = RegisterErrorState(
            model: state.model, message: "Ha ocurrido un error inesperado");
      }
    } catch (e) {
      newState = RegisterErrorState(
          model: state.model, message: "Ha ocurrido un error inesperado");
      emit(newState);
    }

    emit(newState);
  }
}
