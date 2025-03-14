import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/app/login/domain/use_case/logout_use_case.dart';
import 'package:storeapp/app/users/domain/use_case/get_persons_use_case.dart';
import 'package:storeapp/app/users/presentation/bloc/users_event.dart';
import 'package:storeapp/app/users/presentation/bloc/users_state.dart';
import 'package:storeapp/app/users/presentation/model/user_model.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final GetPersonsUseCase getPersonsUseCase;
  final LogoutUseCase logoutUseCase;

  UsersBloc({required this.getPersonsUseCase, required this.logoutUseCase})
      : super(UsersEmptyState()) {
    on<GetUsersEvent>(_getUsersEvent);
    on<LogOutEvent>(_logOutEvent);
  }

  Future<void> _getUsersEvent(
      GetUsersEvent event, Emitter<UsersState> emit) async {
    late UsersState newState;
    try {
      newState = UsersLoadingState();
      emit(newState);

      final List<UserModel> result = await getPersonsUseCase.invoke();

      if (result.isEmpty) {
        newState = UsersEmptyState();
      } else {
        newState =
            UsersLoadDataState(model: state.model.copyWith(users: result));
      }
      emit(newState);
    } catch (e) {
      newState = UsersErrorState(
          model: state.model, message: "Error al consultar productos");
      emit(newState);
    }
  }

  Future<void> _logOutEvent(LogOutEvent event, Emitter<UsersState> emit) async {
    late UsersState newState;
    await logoutUseCase.invoke();
    newState = LogoutState();
    emit(newState);
  }
}
