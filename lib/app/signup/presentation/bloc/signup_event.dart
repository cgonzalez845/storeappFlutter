sealed class SignupEvent {}

final class NameChangedEvent extends SignupEvent {
  final String name;
  NameChangedEvent({required this.name});
}

final class IdentificationChangedEvent extends SignupEvent {
  final String identification;
  IdentificationChangedEvent({required this.identification});
}

final class ImageChangedEvent extends SignupEvent {
  final String image;
  ImageChangedEvent({required this.image});
}

final class EmailChangedEvent extends SignupEvent {
  final String email;
  EmailChangedEvent({required this.email});
}

final class PasswordChangedEvent extends SignupEvent {
  final String password;
  PasswordChangedEvent({required this.password});
}

final class SubmitEvent extends SignupEvent {
  SubmitEvent();
}
