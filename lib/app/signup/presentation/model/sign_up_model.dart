import 'package:storeapp/app/core/domain/entity/person_entity.dart';

class SignUpModel {
  final String id;
  final String name;
  final String identification;
  final String? urlImage;
  final String email;
  final String? password;

  SignUpModel(
      {required this.id,
      required this.name,
      required this.identification,
      this.urlImage,
      required this.email,
      this.password});

  SignUpModel copyWith(
      {String? email,
      String? name,
      String? identification,
      String? urlImage,
      String? password}) {
    return SignUpModel(
        id: id,
        email: email ?? this.email,
        name: name ?? this.name,
        identification: identification ?? this.identification,
        urlImage: urlImage ?? this.urlImage,
        password: password ?? this.password);
  }

  PersonEntity toEntity() => PersonEntity(
      id: id,
      name: name,
      email: email,
      identification: int.parse(identification),
      imageUrl: urlImage,
      password: password);
}
