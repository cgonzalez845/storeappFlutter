class UserModel {
  final String? id;
  final String? personId;
  final String name;
  final String identification;
  final String? urlImage;
  final String email;
  final String? password;

  UserModel(
      {this.id,
      this.personId,
      required this.name,
      required this.identification,
      this.urlImage,
      required this.email,
      this.password});

  UserModel copyWith(
      {String? email,
      String? name,
      String? identification,
      String? urlImage,
      String? password}) {
    return UserModel(
        id: id,
        personId: personId,
        email: email ?? this.email,
        name: name ?? this.name,
        identification: identification ?? this.identification,
        urlImage: urlImage ?? this.urlImage,
        password: password ?? this.password);
  }
}
