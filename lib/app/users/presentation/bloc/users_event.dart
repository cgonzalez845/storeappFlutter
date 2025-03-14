sealed class UsersEvent {}

final class GetUsersEvent extends UsersEvent {
  GetUsersEvent();
}

final class LogOutEvent extends UsersEvent {
  LogOutEvent();
}
