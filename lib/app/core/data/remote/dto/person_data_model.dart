import 'package:storeapp/app/core/domain/entity/person_entity.dart';
import 'package:storeapp/app/signup/presentation/model/sign_up_model.dart';
import 'package:storeapp/app/users/presentation/model/user_model.dart';

class PersonDataModel {
  final String id;
  final String? key;
  late final String name;
  late final int identification;
  late final String? imageUrl;
  late final String email;
  late final String? password;

  PersonDataModel({
    required this.id,
    this.key,
    required this.name,
    required this.identification,
    this.imageUrl,
    required this.email,
    this.password,
  });

  PersonDataModel.fromJson(
      String this.id, String this.key, Map<String, dynamic> json) {
    name = json["name"];
    identification = json["identification"];
    imageUrl = json["image"] ?? "";
    email = json["email"];
    //password = json["password"];
  }

  /*Map<String, Map<String, dynamic>> toJson() {
    return <String, Map<String, dynamic>>{
      id: {
        "name": name,
        "identification": identification,
        "image": imageUrl,
        "email": email,
        //"password": password,
      }
    };
  }*/

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "name": name,
      "identification": identification,
      "image": imageUrl,
      "email": email,
      //"password": password,
    };
  }

  Map<String, dynamic> toUserJson() {
    return <String, dynamic>{
      "email": email,
      "password": password,
    };
  }

  PersonEntity toEntity() {
    return PersonEntity(
        id: id,
        name: name,
        identification: identification,
        imageUrl: imageUrl,
        email: email,
        password: password);
  }

  SignUpModel toModel() {
    return SignUpModel(
      id: id,
      name: name,
      identification: identification.toString(),
      urlImage: imageUrl,
      email: email,
      //password: password
    );
  }

  UserModel toUserModel() {
    return UserModel(
      id: id,
      name: name,
      identification: identification.toString(),
      urlImage: imageUrl,
      email: email,
      //password: password
    );
  }
}
