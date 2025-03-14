import 'package:storeapp/app/core/data/remote/dto/person_data_model.dart';

final class PersonEntity {
  String id;
  final String name;
  final int identification;
  final String? imageUrl;
  final String email;
  final String? password;

  PersonEntity(
      {required this.id,
      required this.name,
      required this.identification,
      this.imageUrl,
      required this.email,
      this.password});
/*ProductModel toProductModel() {
    return ProductModel(id: id, name: name, imageUrl: imageUrl, price: price);
  }*/

  PersonDataModel toPersonDataModel() {
    return PersonDataModel(
      id: id,
      name: name,
      identification: identification,
      imageUrl: imageUrl,
      email: email,
      password: password,
    );
  }
}
