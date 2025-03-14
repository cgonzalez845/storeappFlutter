import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/app/home/domain/use_case/delete_products_use_case.dart';
import 'package:storeapp/app/home/domain/use_case/get_products_use_case.dart';
import 'package:storeapp/app/home/presentation/bloc/home_event.dart';
import 'package:storeapp/app/home/presentation/bloc/home_state.dart';
import 'package:storeapp/app/home/presentation/model/product_model.dart';
import 'package:storeapp/app/login/domain/use_case/logout_use_case.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProductsUseCase getProductsUseCase;
  final DeleteProductsUseCase deleteProductsUseCase;
  final LogoutUseCase logoutUseCase;

  HomeBloc({ required this.getProductsUseCase, required this.deleteProductsUseCase, required this.logoutUseCase}) : super(HomeEmptyState()) {
    //on<ProductChangedEvent>(_getProductsChangedEvent);
    on<GetProductsEvent>(getProductsEvent);
    on<DeleteProductsEvent>(_deleteProductsEvent);
    on<LogOutEvent>(_logOutEvent);

    //_getProductsUseCase = GetProductsUseCase();
  }

  Future<void> getProductsEvent(GetProductsEvent event, Emitter<HomeState> emit) async {
    late HomeState newState;
    try {
      newState = HomeLoadingState();
      emit(newState);

      final List<ProductModel> result = await getProductsUseCase.invoke();

      if(result.isEmpty) {
        newState = HomeEmptyState();
      } else {
        newState = HomeLoadDataState(model: state.model.copyWith(products: result));
      }
      emit(newState);
    } catch (e) {
      newState = HomeErrorState(model: state.model, message: "Error al consultar productos");
      emit(newState);
    }
  }

   Future<void> _deleteProductsEvent(DeleteProductsEvent event, Emitter<HomeState> emit) async {
    late HomeState newState;
    try {
      newState = HomeLoadingState();
      emit(newState);

      final bool result = await deleteProductsUseCase.invoke(event.id);

      if(result) {
        await getProductsEvent(GetProductsEvent(), emit);
      } else {
        throw(Exception());
      }
      //emit(newState);
    } catch (e) {
      newState = HomeErrorState(model: state.model, message: "Error al consultar productos");
      emit(newState);
    }
    
  }

  /*void _getProductsChangedEvent(
    ProductChangedEvent event,
    Emitter<HomeState> emit,
  ) {
    final newState = HomeUpdateState(
      model: state.model.copyWith(products: event.products),
    );
    emit(newState);
  }*/

  Future<void> _logOutEvent(LogOutEvent event, Emitter<HomeState> emit) async {
    late HomeState newState;
    await logoutUseCase.invoke();
    newState = LogoutState();
    emit(newState);
  }
}

/**
 * import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/app/login/domain/use_case/login_use_case.dart';
import 'package:storeapp/app/login/presentation/bloc/login_event.dart';
import 'package:storeapp/app/login/presentation/bloc/login_state.dart';
import 'package:storeapp/app/login/presentation/model/login_form_model.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

late final LoginUseCase _loginUseCase;

  //LoginBloc(super.initialState);
  LoginBloc() : super(InitialState()) {
    on<EmailChangedEvent>(_emailChangedEvent);
    on<PasswordChangedEvent>(_passwordChangedEvent);
    on<SubmitEvent>(_submitEvent);

    _loginUseCase = LoginUseCase();
  }

  //FutureOr<void> _emailChangedEvent(EmailChangedEvent event, Emitter<LoginState> emit) {
  void _emailChangedEvent(EmailChangedEvent event, Emitter<LoginState> emit) {
    /*final oldData = state.model;
    final newData = LoginFormModel(email: event.email, password: state.model.password);
    final newState = EventState(model: newData);*/

    final newState = EventState(
      model: state.model.copyWith(email: event.email),
    );

    emit(newState);
  }

  //FutureOr<void> _passwordChangedEvent(PasswordChangedEvent event, Emitter<LoginState> emit) {
  void _passwordChangedEvent(
    PasswordChangedEvent event,
    Emitter<LoginState> emit,
  ) {
    final newState = EventState(
      model: state.model.copyWith(password: event.password),
    );

    emit(newState);
  }

  //FutureOr<void> _submitEvent(SubmitEvent event, Emitter<LoginState> emit) {
  void _submitEvent(SubmitEvent event, Emitter<LoginState> emit) {
    final bool result = _loginUseCase.invoke(state.model);
    late final LoginState newState;

    if (result) {
      newState = LoginSuccessState(model: state.model);
    } else {
      newState = LoginErrorState(model: state.model, message: "Ha ocurrido un error inesperado");
    }

    emit(newState);
  }
}

 */
